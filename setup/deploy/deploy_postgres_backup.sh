#!/bin/bash
# 
# 脚本名称: deploy_postgres_backup.sh
# 描述: 使用 Podman 部署单个 PostgreSQL 容器，并支持备份和恢复功能。
# 

# ----------------------------------------------------
# 1. 配置参数 (请根据需要修改)
# ----------------------------------------------------
export PG_IMAGE="postgres:16-alpine" 
export PG_CONTAINER_NAME="pg-db-instance"
export PG_USER="postgres"
export PG_PASSWORD="mysecretpassword" 
export PG_DATABASE="mydatabase"

export PG_PORT=5432                 # 对外映射端口
export PG_DATA_VOL="pgdata_vol"     # 持久化卷名称
export BACKUP_HOST_DIR="$(pwd)/pg_backups" # 主机上存放备份文件的绝对路径

# ----------------------------------------------------
# 2. 核心函数：部署 (增强了清理步骤)
# ----------------------------------------------------
deploy_db() {
    echo "--- 检查并清理旧环境 (增强清理) ---"
    
    # 1. 停止并删除容器  podman exec -i $PG_CONTAINER_NAME \
        pg_restore -U $PG_USER -d $PG_DATABASE -c < "$BACKUP_FILE"
    
    if [ $? -eq 0 ]; then
        echo "✅ 数据导入成功！数据库 $PG_DATABASE 已从 $BACKUP_FILE 恢复。"
    else
        echo "❌ 数据导入失败，请检查容器日志。"
    fi
}

# ----------------------------------------------------
# 5. 脚本执行逻辑
# ----------------------------------------------------
case "$1" in
    deploy)
        deploy_db
        ;;
    backup)
        backup_db
        ;;
    restore)
        restore_db "$2"
        ;;
    *)
        echo "用法: $0 [deploy|backup|restore]"
        echo ""
        echo "  deploy:   部署/初始化 PostgreSQL 容器。"
        echo "  backup:   对运行中的容器执行 pg_dump 逻辑备份。"
        echo "  restore <filename>: 使用 <filename> (位于 $BACKUP_HOST_DIR) 恢复数据库。"
        ;;
esac-
# 4. 核心函数：恢复 (与原脚本保持一致)
# ----------------------------------------------------
restore_db() {
    if ! podman container exists $PG_CONTAINER_NAME; then
        echo "错误: 容器 $PG_CONTAINER_NAME 不存在。请先运行 'deploy' 命令。"
        return 1
    fi
    
    local BACKUP_FILE=$1

    if [ -z "$BACKUP_FILE" ]; then
        echo "错误: 请提供要恢复的备份文件的完整路径或文件名。"
        echo "可用备份文件:"
        ls -lh "$BACKUP_HOST_DIR" 2>/dev/null
        return 1
    fi

    if [[ ! "$BACKUP_FILE" =~ ^/ ]]; then
        BACKUP_FILE="$BACKUP_HOST_DIR/$BACKUP_FILE"
    fi

    if [ ! -f "$BACKUP_FILE" ]; then
        echo "错误: 备份文件不存在: $BACKUP_FILE"
        return 1
    fi

    echo "--- 开始执行数据导入/恢复 (pg_restore) ---"
    echo "正在将 $BACKUP_FILE 导入到 $PG_CONTAINER_NAME 中的数据库 $PG_DATABASE"
    
  ----------
# 3. 核心函数：备份 (与原脚本保持一致)
# ----------------------------------------------------
backup_db() {
    if ! podman container exists $PG_CONTAINER_NAME; then
        echo "错误: 容器 $PG_CONTAINER_NAME 不存在。请先运行 'deploy' 命令。"
        return 1
    fi

    local TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    local BACKUP_FILE="$BACKUP_HOST_DIR/db_backup_${PG_DATABASE}_${TIMESTAMP}.custom"
    
    echo "--- 开始执行逻辑备份 (pg_dump) ---"
    echo "备份文件路径: $BACKUP_FILE"
    
    podman exec $PG_CONTAINER_NAME \
        pg_dump -U $PG_USER -d $PG_DATABASE -F c > $BACKUP_FILE
    
    if [ $? -eq 0 ]; then
        echo "✅ 备份成功！文件已保存到: $BACKUP_FILE"
    else
        echo "❌ 备份失败，请检查容器日志: podman logs $PG_CONTAINER_NAME"
    fi
}

# --------------------------------------------------- 容器: $PG_CONTAINER_NAME ---"
    # 注意: 如果端口 5432 仍被其他非 Podman 进程占用 (如您的 lsof 所示)，
    # 您可能需要更改 PG_PORT 的值，或者先停止那个占用 5432 的进程。
    podman run -d \
        --name $PG_CONTAINER_NAME \
        -p $PG_PORT:5432 \
        -e POSTGRES_USER=$PG_USER \
        -e POSTGRES_PASSWORD=$PG_PASSWORD \
        -e POSTGRES_DB=$PG_DATABASE \
        -v $PG_DATA_VOL:/var/lib/postgresql/data \
        $PG_IMAGE

    echo "等待数据库启动 (10 秒)..."
    sleep 10
    
    # 检查数据库是否启动成功
    if ! podman exec $PG_CONTAINER_NAME pg_isready -d $PG_DATABASE -U $PG_USER; then
        echo "错误: 数据库容器启动或初始化失败，请检查日志！"
        echo "如果容器因为端口问题启动失败，请更改 PG_PORT 的值。"
        exit 1
    fi
    echo "PostgreSQL 部署成功！容器名: $PG_CONTAINER_NAME, 端口: $PG_PORT"
}

# ------------------------------------------ (强制操作，即使正在使用卷)
    podman stop $PG_CONTAINER_NAME &> /dev/null
    podman rm -f $PG_CONTAINER_NAME &> /dev/null
    echo "旧容器 $PG_CONTAINER_NAME 已停止并删除。"

    # 2. 删除卷 (现在容器已被删除，卷可以被安全删除了)
    # 使用 if/else 结构来避免在卷不存在时报错，同时处理已存在的情况
    if podman volume exists $PG_DATA_VOL; then
        echo "正在删除旧卷 $PG_DATA_VOL..."
        podman volume rm $PG_DATA_VOL 
    fi

    echo "--- 准备资源 ---"
    # 创建备份目录
    mkdir -p $BACKUP_HOST_DIR
    
    # 尝试创建卷 (现在可以安全创建，因为旧的已被删除)
    if podman volume create $PG_DATA_VOL; then
        echo "持久化卷 $PG_DATA_VOL 已创建。"
    else
        # 这是一个双重检查，理论上不应该发生，但能捕获意外错误
        echo "错误: 无法创建卷 $PG_DATA_VOL。请手动检查: podman volume ls"
        exit 1
    fi
    
    echo "备份目录 $BACKUP_HOST_DIR 已就绪。"

    # 3. 部署容器
    echo "--- 部署 PostgreSQL
