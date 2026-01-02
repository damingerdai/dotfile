#!/bin/zsh

# Check if URL is provided
if [ -z "$1" ]; then
  echo "❌ Error: No download URL provided."
  echo "Usage: ./jdk-installer.sh <jdk_download_url>"
  exit 1
fi

JDK_URL=$1
TEMP_FILE="jdk_archive.tar.gz"
INSTALL_BASE_DIR="/usr/local/java"
ZSHRC="$HOME/.zshrc"

echo "🌐 Starting download from: $JDK_URL"

# 1. Download the JDK
curl -OL "$JDK_URL" -o "$TEMP_FILE"
if [ $? -ne 0 ]; then
  echo "❌ Error: Download failed. Please check the URL."
  exit 1
fi

# 2. Extract Archive Name and Version
# This regex extracts folder name (e.g., jdk-25.0.1) from the tarball content
ACTUAL_FILENAME=$(ls | grep "openjdk-.*_linux-x64_bin.tar.gz" | head -n 1)
[ -z "$ACTUAL_FILENAME" ] && ACTUAL_FILENAME=$TEMP_FILE

echo "📦 Extracting archive..."
# Create a temp directory to find the internal folder name
mkdir -p ./temp_extract
tar -xf "$ACTUAL_FILENAME" -C ./temp_extract
JDK_FOLDER_NAME=$(ls ./temp_extract | head -n 1)

# 3. Move to System Directory
echo "📂 Installing $JDK_FOLDER_NAME to $INSTALL_BASE_DIR..."
sudo mkdir -p "$INSTALL_BASE_DIR"
sudo rm -rf "$INSTALL_BASE_DIR/$JDK_FOLDER_NAME" # Clean old install if exists
sudo mv "./temp_extract/$JDK_FOLDER_NAME" "$INSTALL_BASE_DIR/"
rm -rf ./temp_extract

# 4. Update ZSH Configuration
echo "📝 Updating $ZSHRC..."

# Remove any existing JAVA_HOME blocks to prevent duplicates
sed -i '/# JAVA_INSTALLER_START/,/# JAVA_INSTALLER_END/d' "$ZSHRC"

# Append new configuration with markers
cat <<EOF >>"$ZSHRC"

# JAVA_INSTALLER_START
export JAVA_HOME=$INSTALL_BASE_DIR/$JDK_FOLDER_NAME
export PATH=\$JAVA_HOME/bin:\$PATH
# JAVA_INSTALLER_END
EOF

# 5. Cleanup
rm "$ACTUAL_FILENAME" 2>/dev/null

echo "-------------------------------------------"
echo "✅ Installation successful!"
echo "📍 Installed at: $INSTALL_BASE_DIR/$JDK_FOLDER_NAME"
echo "🔄 Please run: source ~/.zshrc"
echo "🔬 Verification: java -version"
echo "-------------------------------------------"
