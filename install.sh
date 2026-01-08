#!/bin/bash
# Install script for send-to-claude plugin

set -e

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="send-to-claude"
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Installing send-to-claude..."

# Create install directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creating $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
fi

# Create symlink to install directory
echo "Creating symlink $INSTALL_DIR/$SCRIPT_NAME..."
ln -sf "$PLUGIN_DIR/scripts/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"

# Check if PATH includes install directory
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠️  WARNING: $INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add this to your ~/.zshrc or ~/.bashrc:"
    echo ""
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
    echo "Then run: source ~/.zshrc (or ~/.bashrc)"
    echo ""
else
    echo "✅ PATH is configured correctly"
fi

# Test installation
if command -v send-to-claude &> /dev/null; then
    echo ""
    echo "✅ Installation successful!"
    echo ""
    echo "Usage:"
    echo "  send-to-claude \"Your message\""
    echo "  send-to-claude --delay 0.2 \"Fast message\""
    echo ""
else
    echo ""
    echo "❌ Installation failed. Please check your PATH and try again."
    exit 1
fi
