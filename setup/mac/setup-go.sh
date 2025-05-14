#!/bin/bash

# 检查Homebrew是否安装
if ! command -v brew &>/dev/null; then
  echo "错误：Homebrew未安装，请先安装Homebrew！"
  echo "访问 https://brew.sh/ 获取安装指令"
  exit 1
fi

# 更新Homebrew确保获取最新版本信息
echo "正在更新Homebrew仓库..."
brew update

# 检查Go是否已安装
if command -v go &>/dev/null; then
  echo "检测到已安装Go，正在尝试升级到最新版本..."
  brew upgrade golang
else
  echo "未检测到Go，正在执行全新安装..."
  brew install golang
fi

# 验证安装结果
if command -v go &>/dev/null; then
  echo "✅ Go 安装/升级成功！"
  echo "当前版本：$(go version)"
else
  echo "⚠️  操作未成功，请检查错误信息"
  exit 1
fi
