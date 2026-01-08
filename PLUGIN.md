---
name: send-to-claude
version: 0.1.0
author: Jiaming Shan (Stella)
description: Send messages to Claude Code from anywhere - perfect for callbacks, progress reports, and async notifications
repository: https://github.com/shanjiaming/send-to-claude-plugin
installCommand: ./install.sh
tags:
  - automation
  - callback
  - notification
  - background-tasks
---

# Send to Claude Plugin

Enable flexible callbacks and notifications for Claude Code! Send messages to Claude from:
- 🔄 **Background scripts** - Get notified when long-running tasks complete
- 📊 **Progress reports** - Training scripts can report progress mid-execution
- 🔁 **Self-triggers** - Claude can send messages to itself (e.g., for restarts)
- 🌐 **Remote calls** - Trigger Claude from external services

## Why This Plugin?

Claude Code's built-in Background Agents can only notify on completion. This plugin gives you **flexible, any-time callbacks**:

- ✅ Report progress during execution (not just at the end)
- ✅ Call from any script at any point
- ✅ Works in both tmux and iTerm2
- ✅ Auto-detects your terminal environment
- ✅ Configurable delays for reliable message delivery

## How It Works

Once installed, **Claude automatically knows when to use callbacks**:

- **User says**: "Train this model and notify me when done"
- **Claude does**: Creates training script with embedded `send-to-claude` calls
- **User gets**: Automatic notifications without manual intervention

The included `background-callback` skill teaches Claude to detect when you want notifications and embed callbacks naturally in the code it writes.

## Installation

### Prerequisites

The `send-to-claude` script will be installed to `~/.local/bin/`. Make sure this directory is in your PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Add this to your `~/.zshrc` or `~/.bashrc` if it's not already there.

### Install via Claude Code

```
/plugin marketplace add https://github.com/shanjiaming/send-to-claude-plugin
/plugin install send-to-claude
```

The script will be automatically installed during plugin installation.

## Quick Test

After installation, ask Claude to test the callback:

```
Test the callback mechanism
```

Claude will run a background task that sends a message after 3 seconds. The message will appear automatically, proving background callbacks work.

## Usage

### From Python Scripts

```python
import os

# Report progress during training
for epoch in range(100):
    train_one_epoch()
    if epoch % 10 == 0:
        os.system(f'send-to-claude "Training progress: {epoch}/100"')

# Notify on completion
os.system('send-to-claude "Training complete! Check results."')
```

### From Bash Scripts

```bash
#!/bin/bash

# Long running task
./run_experiments.sh

# Callback when done
send-to-claude "Experiments finished! 🎉"
```

### Background Tasks

```bash
# Start a background job with callback
(sleep 300 && send-to-claude "5 minutes passed!") &
```

### Custom Delays

```bash
# Fast (0.1s delay)
send-to-claude --delay 0.1 "Quick message"

# Default (0.5s)
send-to-claude "Normal message"

# Slow (1.0s delay for stability)
send-to-claude --delay 1.0 "Careful message"
```

## How It Works

The plugin installs a `send-to-claude` script that:

1. **Auto-detects** your terminal environment (tmux or iTerm2)
2. **Inherits** environment variables from parent processes
3. **Sends** messages as if you typed them manually
4. **Wakes up** Claude to process the message

### Technical Details

- **tmux**: Uses `tmux send-keys` with configurable delays
- **iTerm2**: Uses AppleScript with built-in timing
- **Environment detection**: Checks `$TMUX` and `$ITERM_SESSION_ID`
- **Reliability**: Separates text input and Enter key to avoid timing issues

## Examples

See the `examples/` directory for:
- `train-callback.py` - ML training with progress reports
- `progress-report.sh` - Bash script with checkpoints
- `self-restart.sh` - Claude triggering its own restart

## Comparison with Background Agents

| Feature | This Plugin | Background Agents |
|---------|-------------|-------------------|
| Report during execution | ✅ Yes | ❌ No |
| Call at any point | ✅ Yes | ❌ Only on completion |
| Self-triggering | ✅ Yes | ❌ No |
| Works in tmux | ✅ Yes | ⚠️ Limited |
| Works in iTerm | ✅ Yes | ✅ Yes |

## License

MIT

## Contributing

Issues and PRs welcome at the repository!
