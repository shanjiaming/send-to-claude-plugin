# Send to Claude - Self-Aware Task Completion for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![tmux](https://img.shields.io/badge/tmux-supported-brightgreen.svg)](https://github.com/tmux/tmux)
[![iTerm2](https://img.shields.io/badge/iTerm2-supported-brightgreen.svg)](https://iterm2.com/)

Let Claude know when background tasks complete - so it can continue working autonomously.

## What Does This Do?

Claude can now complete multi-step workflows autonomously. When you say:

```
"Train this model, then analyze the results and generate a report"
```

Claude will:
1. Start training with embedded callback
2. Get notified when training finishes
3. Automatically continue to analysis
4. You don't need to come back

**Before:** Claude waits indefinitely, you must return to continue.
**After:** Claude knows when tasks finish and continues automatically.

## How It Works

When Claude writes scripts or commands, it adds callbacks using `send-to-claude`:

```python
# Claude automatically embeds this in scripts:
import os
os.system('send-to-claude "Training complete! Starting analysis..."')
```

The `send-to-claude` command:
1. Detects your terminal environment (tmux or iTerm2)
2. Sends text to Claude's terminal as if you typed it
3. Wakes Claude up to continue working

**Supported terminals:** tmux, iTerm2 (auto-detected)

## Installation

In Claude Code:
```
/plugin marketplace add https://github.com/shanjiaming/send-to-claude-plugin
/plugin install send-to-claude
```

Then run `./install.sh` to create symlink in `~/.local/bin/`.

Make sure `~/.local/bin` is in your PATH.

To uninstall: run `./uninstall.sh`

## Usage

Just give Claude multi-step tasks. Claude will automatically add callbacks and continue working when tasks complete.

Test it: Tell Claude "Test the callback mechanism"

## License

MIT License - see [LICENSE](LICENSE)
