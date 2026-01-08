# Send to Claude - Self-Aware Task Completion for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![tmux](https://img.shields.io/badge/tmux-supported-brightgreen.svg)](https://github.com/tmux/tmux)
[![iTerm2](https://img.shields.io/badge/iTerm2-supported-brightgreen.svg)](https://iterm2.com/)

> Let Claude know when background tasks complete - so it can continue working autonomously
>
> **Supports:** tmux and iTerm2 (auto-detected)

## What Does This Do?

This plugin lets Claude **know when tasks finish** so it can **continue working automatically** - without you having to come back and tell it.

**The Problem:**

You ask Claude to do multi-step work:
```
You: "Train this model, then analyze the results and generate a report"
Claude: Starts training...
[Training runs in background]
Claude: "Waiting for training to complete..."
❌ Claude is stuck - it doesn't know when training finishes
❌ You have to come back and say "training is done"
❌ Claude can't continue autonomously
```

**With This Plugin:**

```
You: "Train this model, then analyze the results and generate a report"
Claude: Starts training with callback...
[Training runs in background]
[Training completes → sends message to Claude]
✅ Claude wakes up: "Training complete! Starting analysis..."
✅ Claude continues automatically
✅ You don't need to come back
```

## 🎯 Key Benefits

| Before | After |
|--------|-------|
| ❌ Claude waits indefinitely | ✅ Claude knows when tasks finish |
| ❌ You must return to continue | ✅ Claude continues autonomously |
| ❌ Multi-step workflows break | ✅ Workflows complete automatically |
| ❌ Can only poll or timeout | ✅ Real callbacks that wake Claude |

## 💡 Real Use Cases

### Autonomous Multi-Step Workflows

```
You: "Download the dataset, train the model, evaluate it, and email me the results"
Claude:
  1. Downloads dataset
  2. Starts training with callback
  3. [Training finishes → callback wakes Claude]
  4. Evaluates automatically
  5. Emails results

✅ You set it and forget it
✅ Claude completes all steps autonomously
```

### Progress-Aware Processing

```
You: "Process these 1000 files and generate a summary"
Claude:
  - Processes in batches
  - [Every 100 files → callback to Claude]
  - Claude updates: "Processed 100/1000..."
  - Claude updates: "Processed 200/1000..."
  - [Complete → callback]
  - Claude generates summary automatically
```

### Conditional Logic

```
You: "Train the model. If accuracy > 90%, deploy it. Otherwise, try with more data."
Claude:
  1. Trains model
  2. [Training finishes → callback with accuracy]
  3. Claude checks accuracy
  4. Claude decides and acts automatically
```

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

Then run:

```bash
./install.sh
```

## 🚀 How to Use

Just give Claude multi-step tasks. The plugin works automatically.

**Claude will:**
- Detect when callbacks are needed
- Add them to scripts automatically
- Continue working when tasks complete
- No action needed from you

## 🧪 Test It

After installation:

```
You: "Test the callback mechanism"
Claude: "Starting test..."
[3 seconds later - Claude receives callback]
Claude: "✅ Callback received! The mechanism works."
```

## 🔄 Comparison with Background Agents

| Feature | This Plugin | Background Agents |
|---------|-------------|-------------------|
| Claude continues autonomously | ✅ Yes - Claude knows when tasks finish | ❌ No - waits for user |
| Mid-task updates | ✅ Claude can track progress | ❌ Only final completion |
| Multi-step workflows | ✅ Complete automatically | ❌ Break at each step |
| Works in tmux | ✅ Full support | ⚠️ Limited |

## 🛠️ Technical Details (For Developers)

<details>
<summary>Click to expand</summary>

### How It Works

1. Claude embeds callback calls in scripts automatically
2. When tasks complete, scripts send messages to Claude's terminal
3. Messages appear as if you typed them - waking Claude up
4. Claude sees the message and continues processing

### What Gets Installed

- `send-to-claude` script in `~/.local/bin/`
- `background-callback` skill that teaches Claude when/how to use it
- Auto-detects tmux or iTerm2 environment

### For Plugin Developers

See `skills/background-callback/SKILL.md` for implementation patterns.

Example from the skill:
```python
# Claude automatically adds this to scripts:
import os

def train():
    # training code...
    pass

# Start
os.system('send-to-claude "Training started"')
train()
# Complete
os.system('send-to-claude "Training finished! Accuracy: 94%"')
```

When the script finishes, Claude receives the message and can continue working.

</details>

## 🤝 Contributing

- 🐛 [Report bugs](https://github.com/shanjiaming/send-to-claude-plugin/issues)
- 💡 [Request features](https://github.com/shanjiaming/send-to-claude-plugin/issues)
- 💬 [Discussions](https://github.com/shanjiaming/send-to-claude-plugin/discussions)

## 📄 License

MIT License - see [LICENSE](LICENSE)

## 🙏 Credits

Made with ❤️ by [Stella](https://github.com/shanjiaming)

For [Claude Code](https://code.claude.com/) users who want autonomous multi-step workflows.

---

**Note**: This plugin is for Claude Code, not the web version of Claude.
