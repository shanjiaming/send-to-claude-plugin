# Send to Claude - Flexible Callbacks for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![tmux](https://img.shields.io/badge/tmux-supported-brightgreen.svg)](https://github.com/tmux/tmux)
[![iTerm2](https://img.shields.io/badge/iTerm2-supported-brightgreen.svg)](https://iterm2.com/)

> Send messages to Claude Code from anywhere - perfect for callbacks, progress reports, and async notifications
>
> **Supports:** tmux and iTerm2 (auto-detected)

## ✨ Features

- 🔄 **Background callbacks** - Get notified when long-running tasks complete
- 📊 **Progress reports** - Training scripts can report progress mid-execution
- 🔁 **Self-triggering** - Claude can send messages to itself
- 🌐 **Remote calls** - Trigger Claude from external services
- 🎯 **Auto-detection** - Works in tmux and iTerm2 automatically
- ⚡ **Configurable** - Adjust timing for reliability

## 🎯 Why This Plugin?

Claude Code's built-in Background Agents can only notify on completion. This plugin gives you **flexible, any-time callbacks**:

| Feature | This Plugin | Background Agents |
|---------|-------------|-------------------|
| Report during execution | ✅ Yes | ❌ No |
| Call at any point | ✅ Yes | ❌ Only on completion |
| Self-triggering | ✅ Yes | ❌ No |
| Works in tmux | ✅ Yes | ⚠️ Limited |

## 🤖 How It Works

Once installed, Claude learns when to use callbacks automatically:

- **You say**: "Run this training script and let me know when it's done"
- **Claude does**: Creates script with embedded `send-to-claude` calls
- **You get**: Automatic notifications without manual setup

The `background-callback` skill teaches Claude to:
- Detect when you want notifications
- Embed callbacks in scripts automatically
- Report progress at reasonable intervals
- Wake you up when tasks complete

## 📦 Installation

### Prerequisites

Make sure `~/.local/bin` is in your PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Add to your `~/.zshrc` or `~/.bashrc` if needed.

### Install via Claude Code

```
/plugin marketplace add https://github.com/shanjiaming/send-to-claude-plugin
/plugin install send-to-claude
```

Or install manually:

```bash
git clone https://github.com/shanjiaming/send-to-claude-plugin.git
cd send-to-claude-plugin
./install.sh
```

## 🚀 Quick Start

### Test the callback

After installation, ask Claude to test it:

```
Test the callback mechanism
```

Claude will run:
```bash
(sleep 3 && send-to-claude "✅ Callback test successful! Received after 3 seconds.") &
```

You'll see the message appear automatically after 3 seconds, proving the callback works!

### From Python

```python
import os

for epoch in range(100):
    train()
    if epoch % 10 == 0:
        os.system(f'send-to-claude "Progress: {epoch}/100"')
```

### From Bash

```bash
./long_script.sh && send-to-claude "Done! 🎉"
```

### Background Task

```bash
(sleep 300 && send-to-claude "5 minutes passed!") &
```

## 📖 Usage

### Basic

```bash
send-to-claude "Your message here"
```

### With Custom Delay

```bash
# Fast (0.1s)
send-to-claude --delay 0.1 "Quick message"

# Default (0.5s)
send-to-claude "Normal message"

# Slow (1.0s)
send-to-claude --delay 1.0 "Careful message"
```

### Get Help

```bash
send-to-claude --help
```

## 🎓 Examples

See the [`examples/`](./examples/) directory:

- [`train-callback.py`](./examples/train-callback.py) - ML training with progress reports
- [`progress-report.sh`](./examples/progress-report.sh) - Bash script with checkpoints

Run them:

```bash
python examples/train-callback.py
bash examples/progress-report.sh
```

## 🔧 How It Works

1. **Auto-detects** your terminal (tmux or iTerm2) via environment variables
2. **Inherits** session info from parent processes
3. **Sends** messages as if you typed them manually
4. **Wakes up** Claude to process the message

### Technical Details

- **tmux**: `tmux send-keys` with configurable delays
- **iTerm2**: AppleScript with built-in timing
- **Detection**: Checks `$TMUX` and `$ITERM_SESSION_ID`
- **Reliability**: Separates text and Enter to avoid timing issues

## 🎨 Use Cases

### Training Callbacks

```python
def train():
    send_to_claude("Training started")
    for epoch in range(100):
        # ... training ...
        if epoch % 10 == 0:
            send_to_claude(f"Epoch {epoch}/100 complete")
    send_to_claude("Training finished!")
```

### Experiment Completion

```bash
# Run multiple experiments
for config in config1 config2 config3; do
    ./experiment.sh $config
    send-to-claude "Experiment $config done!"
done
```

### Self-Restart

```bash
# Claude can trigger its own restart
send-to-claude "/exit"
sleep 2
send-to-claude "claude -c"
```

### Remote Trigger

```bash
# From another machine (via SSH)
ssh your-machine "send-to-claude 'Check the results!'"
```

## 🛠️ Development

### Project Structure

```
send-to-claude-plugin/
├── PLUGIN.md              # Plugin metadata
├── README.md              # This file
├── install.sh             # Installation script
├── skills/
│   └── background-callback/
│       └── SKILL.md       # Teaches Claude when/how to use callbacks
├── scripts/
│   └── send-to-claude     # Main executable
└── examples/
    ├── train-callback.py  # Python example
    └── progress-report.sh # Bash example
```

### Testing

```bash
# Test in tmux
tmux
send-to-claude "Test from tmux"

# Test in iTerm
send-to-claude "Test from iTerm"

# Test background callback
(sleep 3 && send-to-claude "Callback after 3 seconds") &
```

## 🤝 Contributing

Contributions welcome! Please:

1. Fork the repo
2. Create a feature branch
3. Make your changes
4. Submit a PR

## 📄 License

MIT License - see [LICENSE](LICENSE) for details

## 🙏 Acknowledgments

- Built for [Claude Code](https://code.claude.com/)
- Inspired by the need for flexible async callbacks
- Community feedback and testing

## 📮 Support

- 🐛 [Report bugs](https://github.com/shanjiaming/send-to-claude-plugin/issues)
- 💡 [Request features](https://github.com/shanjiaming/send-to-claude-plugin/issues)
- 💬 [Discussions](https://github.com/shanjiaming/send-to-claude-plugin/discussions)

---

Made with ❤️ by [Stella](https://github.com/shanjiaming)
