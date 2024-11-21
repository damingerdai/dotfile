#!/bin/sh

# 默认值
DEFAULT_VERSION="1.23.0"
DEFAULT_MIRROR="https://golang.org"

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

# 构建下载链接
URL="${MIRROR}/dl/go${VERSION}.linux-amd64.tar.gz"

# 下载并安装 Go
echo "Downloading Go from ${URL}..."
curl -OL "$URL" || {
	echo "Download failed! Exiting."
	exit 1
}

echo "Extracting Go to /usr/local..."
sudo tar -C /usr/local -xvf "go${VERSION}.linux-amd64.tar.gz" || {
	echo "Extraction failed! Exiting."
	exit 1
}

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
