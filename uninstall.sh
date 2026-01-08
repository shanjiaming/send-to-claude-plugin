#!/bin/bash
# Uninstall script for send-to-claude plugin

set -e

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="send-to-claude"

echo "🗑️  Uninstalling send-to-claude..."

if [ -L "$INSTALL_DIR/$SCRIPT_NAME" ] || [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
    rm -f "$INSTALL_DIR/$SCRIPT_NAME"
    echo "✅ Removed $INSTALL_DIR/$SCRIPT_NAME"
else
    echo "⚠️  $SCRIPT_NAME not found in $INSTALL_DIR"
fi

echo ""
echo "✅ Uninstallation complete!"
