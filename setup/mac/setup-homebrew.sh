#!/usr/bin/env bash

# 脚本目标：安装 Homebrew (如果尚未安装) 并配置国内镜像源

# --- 基本设置 ---
# set -euo pipefail # 在脚本开头使用这些选项通常是好习惯，增强健壮性
                    # -e: 命令失败时立即退出
                    # -u: 使用未定义变量时报错
                    # -o pipefail: 管道中任一命令失败则整个管道失败
                    # 这里暂时注释掉，因为Homebrew安装脚本内部可能有自己的错误处理

# --- 颜色定义 (可选，美化输出) ---
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- 函数：打印信息 ---
info() {
    printf "${GREEN}[INFO] %s${NC}\n" "$1"
}

warn() {
    printf "${YELLOW}[WARN] %s${NC}\n" "$1"
}

error() {
    printf "${RED}[ERROR] %s${NC}\n" "$1" >&2
}

# --- 函数：检查命令是否存在 ---
command_exists() {
    command -v "$1" &> /dev/null
}

# --- 函数：将配置写入 Shell 配置文件 ---
# 参数1: 配置行的数组
# 参数2: Shell 配置文件路径
append_to_shell_config() {
    local -n config_lines_ref="$1" # 使用 nameref 引用数组
    local shell_config_file="$2"
    local restart_needed=0

    info "正在尝试将 Homebrew 镜像配置写入 $shell_config_file..."

    # 先移除旧的由本脚本添加的 Homebrew 镜像配置
    # 使用 grep -q 判断是否存在，避免文件不存在时 sed 报错 (虽然 sed 通常会忽略)
    if [ -f "$shell_config_file" ]; then
        sed -i.bak '/# --- Homebrew Mirror Configuration (added by script) ---/,/# --- End Homebrew Mirror Configuration ---/d' "$shell_config_file"
        # 移除可能产生的空行，可选
        if command_exists sed; then # 确保 sed 可用
             sed -i.bak '/^$/N;/^\n$/D' "$shell_config_file" # 移除连续空行
        fi
    fi


    # 追加新的配置
    {
        printf "\n# --- Homebrew Mirror Configuration (added by script) ---\n"
        for line in "${config_lines_ref[@]}"; do
            printf "%s\n" "$line"
        done
        printf "# --- End Homebrew Mirror Configuration ---\n"
    } >> "$shell_config_file"

    info "配置已写入 $shell_config_file。"
    warn "请运行 'source $shell_config_file' 或重新打开终端使配置生效。"
}

# --- 函数：设置并导出环境变量 (当前会话) ---
# 参数: 镜像类型的名称 (e.g., "ustc", "aliyun", "official")
apply_mirror_settings_for_session() {
    local mirror_type="$1"

    # 清除可能存在的旧环境变量，避免冲突
    unset HOMEBREW_INSTALL_FROM_API
    unset HOMEBREW_API_DOMAIN
    unset HOMEBREW_BOTTLE_DOMAIN
    unset HOMEBREW_BREW_GIT_REMOTE
    unset HOMEBREW_CORE_GIT_REMOTE
    # Homebrew Cask (如果需要)
    unset HOMEBREW_CASKS_GIT_REMOTE

    case "$mirror_type" in
        "ustc")
            export HOMEBREW_INSTALL_FROM_API=1
            export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
            export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
            export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
            export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
            # export HOMEBREW_CASKS_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-cask.git" # 如果需要 Cask 镜像
            info "当前会话已配置使用 USTC 镜像。"
            ;;
        "aliyun")
            export HOMEBREW_INSTALL_FROM_API=1
            export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api"
            export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles"
            export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
            export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
            # export HOMEBREW_CASKS_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-cask.git" # 如果需要 Cask 镜像
            info "当前会话已配置使用 Aliyun 镜像。"
            ;;
        "official"|*)
            info "当前会话将使用 Homebrew 官方源。"
            # 无需设置特定环境变量，清除即可
            ;;
    esac
}


# --- 主逻辑 ---

# 1. Homebrew 安装
if ! command_exists brew; then
    info "Homebrew 未安装。正在开始安装..."
    # 在安装前设置镜像环境变量，可能有助于加速下载安装脚本依赖（尽管安装脚本本身可能不会使用所有这些变量）
    # 这里可以选择一个默认的镜像来加速安装过程，或者让用户先选择
    warn "为了加速 Homebrew 自身的下载，建议先临时设置一个镜像源。"
    warn "Homebrew 安装脚本将从 GitHub 下载。如果 GitHub 访问不畅，请确保网络通畅。"
    
    # 这里可以临时设置一个镜像，例如USTC，让安装过程更快
    # apply_mirror_settings_for_session "ustc" # 取消注释以在安装前临时应用USTC镜像

    # 执行Homebrew官方安装脚本
    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # 非交互式安装（如果需要）：
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


    if ! command_exists brew; then
        error "Homebrew 安装失败。请检查网络或尝试手动安装。"
        # 尝试添加 Homebrew 到 PATH (Linuxbrew 的常见情况)
        if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
             info "尝试将 /home/linuxbrew/.linuxbrew/bin 添加到 PATH"
             export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
        elif [ -d "$HOME/.linuxbrew/bin" ]; then
            info "尝试将 $HOME/.linuxbrew/bin 添加到 PATH"
            export PATH="$HOME/.linuxbrew/bin:$PATH"
        elif [ -x "/opt/homebrew/bin/brew" ]; then # macOS Apple Silicon
            info "尝试将 /opt/homebrew/bin 添加到 PATH"
            export PATH="/opt/homebrew/bin:$PATH"
        fi

        if ! command_exists brew; then
             error "仍未找到 brew 命令。请参照 Homebrew 官方文档进行故障排查。"
             exit 1
        fi
    fi
    info "Homebrew 安装成功！"
else
    info "Homebrew 已安装。"
fi

# 2. 镜像选择和配置
info "请选择要使用的 Homebrew 镜像源:"
options=("USTC (中国科学技术大学)" "Aliyun (阿里云)" "Official (官方源，不使用镜像)" "Skip (跳过配置)")
select opt in "${options[@]}"; do
    case "$opt" in
        "USTC (中国科学技术大学)")
            mirror_choice="ustc"
            config_lines=(
                'export HOMEBREW_INSTALL_FROM_API=1'
                'export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"'
                'export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"'
                'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"'
                'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"'
                # 'export HOMEBREW_CASKS_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-cask.git"'
            )
            break
            ;;
        "Aliyun (阿里云)")
            mirror_choice="aliyun"
            config_lines=(
                'export HOMEBREW_INSTALL_FROM_API=1'
                'export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api"'
                'export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles"'
                'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"'
                'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"'
                # 'export HOMEBREW_CASKS_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-cask.git"'
            )
            break
            ;;
        "Official (官方源，不使用镜像)")
            mirror_choice="official"
            config_lines=() # 清空配置
            break
            ;;
        "Skip (跳过配置)")
            info "跳过镜像配置。"
            exit 0
            ;;
        *) warn "无效选项，请重新选择。";;
    esac
done

# 3. 应用配置
apply_mirror_settings_for_session "$mirror_choice"

# 4. 持久化配置 (写入 Shell 配置文件)
SHELL_CONFIG_FILE=""
CURRENT_SHELL="$(basename "$SHELL")"

if [ "$CURRENT_SHELL" = "bash" ]; then
    SHELL_CONFIG_FILE="$HOME/.bashrc"
elif [ "$CURRENT_SHELL" = "zsh" ]; then
    SHELL_CONFIG_FILE="$HOME/.zshrc"
else
    warn "无法自动检测到 .bashrc 或 .zshrc。您可能需要手动将以下配置添加到您的 Shell 配置文件中 (例如 $HOME/.profile 或其他):"
    if [ ${#config_lines[@]} -gt 0 ]; then
        for line in "${config_lines[@]}"; do
            printf "%s\n" "$line"
        done
    else
        info "选择的是官方源，无需添加额外配置，但请确保旧的镜像配置已从Shell配置文件中移除。"
    fi
    exit 0 # 正常退出，让用户手动处理
fi

# 确保配置文件存在，如果不存在则创建
touch "$SHELL_CONFIG_FILE"

if [ "$mirror_choice" = "official" ]; then
    info "正在从 $SHELL_CONFIG_FILE 中移除所有由本脚本添加的 Homebrew 镜像配置..."
    if [ -f "$SHELL_CONFIG_FILE" ]; then
        sed -i.bak '/# --- Homebrew Mirror Configuration (added by script) ---/,/# --- End Homebrew Mirror Configuration ---/d' "$SHELL_CONFIG_FILE"
        # 移除可能产生的空行
        if command_exists sed; then
            sed -i.bak '/^$/N;/^\n$/D' "$SHELL_CONFIG_FILE"
        fi
    fi
    info "已选择官方源。旧的镜像配置（如果存在）已从 $SHELL_CONFIG_FILE 中移除。"
    warn "请运行 'source $SHELL_CONFIG_FILE' 或重新打开终端使更改生效。"
else
    append_to_shell_config config_lines "$SHELL_CONFIG_FILE"
fi

info "脚本执行完毕。"
