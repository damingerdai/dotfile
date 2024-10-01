#!/bin/bash

PROFILE_INSTALL_DIR="$HOME/.nvm"
SOURCE_STR="\\nexport NVM_DIR=\"${PROFILE_INSTALL_DIR}\"\\n[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"  # This loads nvm\\n"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
"${SOURCE_STR}" >> ~/.zshrc && \
source ~/.zshrc