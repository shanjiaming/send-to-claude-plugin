# Send to Claude - Flexible Callbacks for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![tmux](https://img.shields.io/badge/tmux-supported-brightgreen.svg)](https://github.com/tmux/tmux)
[![iTerm2](https://img.shields.io/badge/iTerm2-supported-brightgreen.svg)](https://iterm2.com/)

> Enable smart callbacks and progress notifications for Claude Code
>
> **Supports:** tmux and iTerm2 (auto-detected)

## What Does This Do?

This plugin teaches Claude to automatically notify you during long-running tasks - without you having to check back constantly.

**Before this plugin:**
- Run a training script → Wait and check back manually
- Start experiments → Poll for completion
- Background tasks → No way to know when they're done

**After this plugin:**
- Run a training script → **Get notified automatically when it's done**
- Start experiments → **Claude tells you progress and completion**
- Background tasks → **Messages appear exactly when you need them**

## 🎯 Key Features

| Feature | What It Means For You |
|---------|----------------------|
| 🔄 **Background Callbacks** | Claude tells you when tasks finish |
| 📊 **Progress Reports** | Get updates during long-running tasks |
| ⏰ **Smart Timing** | Notifications appear at the right moments |
| 🤖 **Zero Manual Work** | Claude handles everything automatically |

## 📦 Installation

### Prerequisites

Make sure `~/.local/bin` is in your PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Add to your `~/.zshrc` or `~/.bashrc` if needed.

### Install the Plugin

In Claude Code:

```
/plugin marketplace add https://github.com/shanjiaming/send-to-claude-plugin
/plugin install send-to-claude
```

Then run the installation script:

```bash
./install.sh
```

## 🚀 How to Use

Just talk to Claude naturally! The plugin works automatically.

### Example Conversations

**Training a Model:**
```
You: "Train this model on the dataset and let me know when it's done"
Claude: "I'll set up the training script with progress notifications..."
[Training starts]
[10 minutes later - automatic message appears]
Claude receives: "Training complete! Final accuracy: 94.2%"
```

**Running Experiments:**
```
You: "Run these 5 experiments in the background and report progress"
Claude: "Starting experiments with progress tracking..."
[Messages appear as each experiment completes]
"Experiment 1/5 done"
"Experiment 2/5 done"
...
"All experiments finished!"
```

**Long Tasks:**
```
You: "Process this large dataset and notify me every 100 batches"
Claude: "Processing with periodic updates..."
[You continue other work]
[Updates appear automatically]
"Progress: 100/500 batches"
"Progress: 200/500 batches"
...
"Processing complete!"
```

## 🧪 Test It

After installation, verify it works:

```
You: "Test the callback mechanism"
Claude: "I've started a test. You'll receive a message in 3 seconds..."
[3 seconds later]
Automatic message appears: "✅ Callback test successful!"
```

## 💡 When Does Claude Use This?

Claude automatically detects when you want notifications based on your requests:

- ✅ "Let me know when..."
- ✅ "Notify me..."
- ✅ "Report progress..."
- ✅ "Run in the background..."
- ✅ "Tell me when it's done..."

You don't need to know any technical details - just ask naturally!

## 🔄 Comparison with Background Agents

| Feature | This Plugin | Background Agents |
|---------|-------------|-------------------|
| Progress during execution | ✅ Claude can report mid-task | ❌ Only at completion |
| Flexible timing | ✅ Updates whenever needed | ❌ Fixed at end |
| Works in tmux | ✅ Full support | ⚠️ Limited |
| User effort | ✅ Zero - completely automatic | ⚠️ Some setup needed |

## 🛠️ Technical Details (For Developers)

<details>
<summary>Click to expand</summary>

### How It Works

1. Claude learns callback patterns from the `background-callback` skill
2. When you request notifications, Claude embeds callback calls in scripts
3. Scripts execute and send messages back automatically
4. Messages appear as if you typed them, waking Claude up

### Supported Terminals

- **tmux**: Uses `tmux send-keys` with configurable delays
- **iTerm2**: Uses AppleScript with precise timing
- Auto-detects via `$TMUX` and `$ITERM_SESSION_ID` environment variables

### Project Structure

```
send-to-claude-plugin/
├── PLUGIN.md                      # Plugin metadata
├── README.md                      # User documentation (this file)
├── install.sh                     # Installation script
├── skills/
│   └── background-callback/
│       └── SKILL.md              # Teaches Claude when/how to use
├── scripts/
│   └── send-to-claude            # Core executable
└── examples/
    ├── train-callback.py         # Example for developers
    └── progress-report.sh        # Example for developers
```

### For Plugin Developers

See `skills/background-callback/SKILL.md` for implementation details and patterns.

</details>

## 🤝 Contributing

Found a bug or have a feature request?

- 🐛 [Report bugs](https://github.com/shanjiaming/send-to-claude-plugin/issues)
- 💡 [Request features](https://github.com/shanjiaming/send-to-claude-plugin/issues)
- 💬 [Discussions](https://github.com/shanjiaming/send-to-claude-plugin/discussions)

## 📄 License

MIT License - see [LICENSE](LICENSE) for details

## 🙏 Credits

Made with ❤️ by [Stella](https://github.com/shanjiaming)

Built for [Claude Code](https://code.claude.com/) users who want smarter notifications.

---

**Note**: This plugin is for Claude Code, not the web version of Claude.
