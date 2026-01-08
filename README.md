# Send to Claude - Self-Aware Task Completion for Claude Code

[English](README.md) | [中文](README.zh-CN.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![tmux](https://img.shields.io/badge/tmux-supported-brightgreen.svg)](https://github.com/tmux/tmux)
[![iTerm2](https://img.shields.io/badge/iTerm2-supported-brightgreen.svg)](https://iterm2.com/)

**Claude can now send messages to its own input to wake itself up.**

This plugin enables autonomous multi-step workflows where Claude continues working without waiting for you to return.

## Requirements

**Your Claude Code session must run in one of these terminals:**
- tmux
- iTerm2

The plugin auto-detects your terminal environment.

---

## The Problem

```
You: Train the model, then analyze results and generate a report
Claude: Starting training...
[10 minutes later training completes]
Claude: (silence)
You: (come back) Is training done?
Claude: Yes! Starting analysis...
```

Claude doesn't know when background tasks complete. Multi-step workflows break here.

---

## The Solution

Let Claude send messages to itself:

```python
# Claude's training script
import os

train_model()  # Takes 10 minutes

# Wake itself up when done
os.system('send-to-claude "Training complete! Accuracy: 94%, starting analysis..."')
```

When the script finishes, **Claude's input receives this message automatically**, Claude wakes up and continues.

**Also enables periodic polling**: Check emails hourly, trigger sleep mechanism every 4 hours, periodic memory consolidation, etc.

---

## How It Works

1. Claude runs in tmux/iTerm2 with environment variables `$TMUX` or `$ITERM_SESSION_ID`
2. Scripts created by Claude inherit these environment variables
3. Script calls `send-to-claude` → finds Claude's session via inherited variables
4. Sends message to Claude's terminal input

Technical implementation:
```bash
# tmux
tmux send-keys -t $session:$window.$pane "message"
sleep 0.5
tmux send-keys -t $session:$window.$pane "Enter"

# iTerm2
tell session to write text "message"
delay 0.5
tell session to write text ""
```

---

## Installation

In Claude Code:
```
/plugin marketplace add https://github.com/shanjiaming/send-to-claude-plugin
/plugin install send-to-claude
```

Then run this command to complete installation:
```bash
bash ~/.claude/plugins/cache/send-to-claude/send-to-claude/0.1.0/install.sh
```

Make sure `~/.local/bin` is in your PATH.

To uninstall:
```bash
bash ~/.claude/plugins/cache/send-to-claude/send-to-claude/0.1.0/uninstall.sh
```

---

## Usage

Just give Claude multi-step tasks:

```
"Train model, then analyze results"
"Process 1000 files, report progress every 100"
"Download data, clean it, train, deploy"
```

Claude automatically adds callbacks to scripts and completes workflows autonomously.

Test it: Tell Claude "Test the callback mechanism"

---

## Comparison with Background Agents

| Feature | send-to-claude | Background Agents |
|---------|----------------|-------------------|
| Task completion callback | ✅ | ✅ |
| Any-time callbacks | ✅ | ❌ Only on completion |
| Claude continues autonomously | ✅ | ❌ Needs user input |
| Multi-step automation | ✅ | ❌ User needed per step |
| Periodic polling | ✅ | ❌ |

---

## Technical Details

**Why not polling?**

Polling occupies session, wastes tokens, blocks other tasks.

Callbacks: Claude releases resources, wakes up precisely when needed, zero consumption while waiting.

**How do environment variables work?**

Unix child processes inherit parent environment variables:

```
Claude (tmux, has $TMUX)
  └─ python train.py (inherits $TMUX)
       └─ os.system('send-to-claude') (inherits $TMUX)
            └─ Reads $TMUX, finds Claude's session
```

---

## Summary

This plugin transforms Claude from "passive responder" to "autonomous worker."

After installation:
- No need to watch progress
- No need to come back and say "continue"
- No need to manually chain steps

**Claude can truly work independently.**

---

## License

MIT License - see [LICENSE](LICENSE)
