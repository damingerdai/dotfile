#!/bin/sh

# 默认值
DEFAULT_VERSION="1.24.3"
DEFAULT_MIRROR="https://go.dev"
GO_DIR="/usr/local/go"
BACKUP_DIR="/usr/local/go-bak"

# 初始化变量
MIRROR="$DEFAULT_MIRROR"
VERSION="$DEFAULT_VERSION"

# 参数解析
while [ "$#" -gt 0 ]; do
  case "$1" in
  --mirror)
    MIRROR="https://golang.google.cn"
    ;;
  --version)
    if [ "$2" ]; then
      VERSION="$2"
      shift
    else
      echo "Error: --version requires a value."
      exit 1
    fi
    ;;
  *)
    echo "Unknown parameter: $1"
    exit 1
    ;;
  esac
  shift
done

# Check if the directory exists
if [ -d "$GO_DIR" ]; then
  # Check if the backup directory already exists
  if [ -d "$BACKUP_DIR" ]; then
    echo "Backup directory $BACKUP_DIR already exists. Remove it."
    rm -r -f "${BACKUP_DIR}"
  fi

  # Rename the directory
  mv "$GO_DIR" "$BACKUP_DIR"
  if [ $? -eq 0 ]; then
    echo "Directory $GO_DIR has been successfully renamed to $BACKUP_DIR."
  else
    echo "Failed to rename the directory. Please check permissions or other issues."
    exit 1
  fi
else
  echo "Directory $GO_DIR does not exist. No action needed."
fi

# 构建下载链接
URL="${MIRROR}/dl/go${VERSION}.linux-amd64.tar.gz"

# 下载并安装 Go
echo "Downloading Go from ${URL}..."
curl -OL "$URL" || {
  echo "Download failed! Exiting."
  exit 1
}

echo "Extracting Go to /usr/local..."
tar -C /usr/local -xvf "go${VERSION}.linux-amd64.tar.gz" || {
  echo "Extraction failed! Exiting."
  exit 1
}

# Delete the backup directory after renaming
echo "Deleting $BACKUP_DIR..."
rm -rf "$BACKUP_DIR"
if [ $? -eq 0 ]; then
  echo "Backup directory $BACKUP_DIR has been successfully deleted."
else
  echo "Failed to delete $BACKUP_DIR after renaming."
  exit 1
fi

# 配置环境变量
if ! grep -q '/usr/local/go/bin' ~/.zshrc; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.zshrc
  echo "Environment variable added to ~/.zshrc"
else
  echo "Environment variable already exists in ~/.zshrc"
fi

# 应用环境变量
echo "Sourcing ~/.zshrc..."
# source ~/.zshrc || {
# 	echo "Please run the following command to apply the changes:"
# 	echo "source ~/.zshrc"
# }

# 手动导入变量
export PATH=$PATH:/usr/local/go/bin
echo "Environment variable applied to current session."
echo "Please run the following command to apply the changes:"
echo "source ~/.zshrc"

# 删除下载的 .tar.gz 文件
echo "Cleaning up downloaded file..."
rm -f "go${VERSION}.linux-amd64.tar.gz" || {
  echo "Failed to delete the tar.gz file."
  exit 1
}

echo "Go ${VERSION} installation completed successfully!"
