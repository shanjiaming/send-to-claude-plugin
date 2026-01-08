---
name: background-callback
description: Guide for using send-to-claude in background tasks and scripts
---

# Background Callback Skill

This skill teaches Claude when and how to use `send-to-claude` to implement callbacks, progress reports, and notifications.

## When to Use

Use `send-to-claude` when the user requests:

1. **Background tasks with notifications**
   - "Run this and let me know when it's done"
   - "Start training in the background and notify me"
   - "Execute this script and tell me the result"

2. **Progress reports**
   - "Report progress during training"
   - "Let me know every 10 epochs"
   - "Update me on the status"

3. **Long-running tasks**
   - Tasks that take >30 seconds
   - Multi-step workflows
   - Experiments or training runs

## How to Use

### In Python Scripts

When creating Python scripts, embed `send-to-claude` at key points:

```python
import os

def callback(msg):
    os.system(f'send-to-claude "{msg}"')

# Start notification
callback("Starting training...")

# Progress updates
for epoch in range(100):
    train()
    if epoch % 10 == 0:
        callback(f"Progress: {epoch}/100 epochs")

# Completion
callback("Training complete! Check results.")
```

### In Bash Scripts

```bash
#!/bin/bash

# Start
send-to-claude "Starting experiments..."

# Run tasks
./experiment1.sh
send-to-claude "Experiment 1 done"

./experiment2.sh
send-to-claude "Experiment 2 done"

# Complete
send-to-claude "All experiments finished!"
```

### Background Commands

When running background tasks:

```bash
# Run in background with callback on completion
(python train.py && send-to-claude "Training finished!") &
```

## Implementation Pattern

When the user asks you to run something with notifications:

1. **Create the script** with embedded `send-to-claude` calls
2. **Use Bash tool** to run it (with `run_in_background: true` if needed)
3. **Tell the user** you'll notify them when it's done
4. **Let the callback wake you up** - don't poll

## Example Scenarios

### Scenario 1: "Train this model and let me know when done"

```python
# Create train.py with callback
import os

def train():
    # ... training code ...
    pass

# Start
os.system('send-to-claude "Starting training..."')

train()

# Done
os.system('send-to-claude "✅ Training complete! Loss: 0.23"')
```

### Scenario 2: "Run experiments in the background"

```bash
# Run with background callback
(
  ./experiment.sh &&
  send-to-claude "✅ Experiment finished! Check results in ./output/"
) &
```

### Scenario 3: "Report progress every 10 iterations"

```python
for i in range(100):
    process()
    if i % 10 == 0:
        os.system(f'send-to-claude "Progress: {i}/100"')
```

## Key Principles

1. **Proactive**: Add callbacks without the user asking for specific syntax
2. **Natural**: Embed in the script you're creating anyway
3. **Informative**: Include useful info in callback messages
4. **Non-intrusive**: Don't over-notify (use reasonable intervals)

## Don't

- ❌ Ask the user to manually call `send-to-claude`
- ❌ Require the user to modify the script
- ❌ Forget to add callbacks when the user wants notifications
- ❌ Over-notify (every line is too much)

## Testing

When the user says "test the callback mechanism":

```bash
(sleep 3 && send-to-claude "✅ Callback test successful! Received after 3 seconds.") &
```

Then explain: "I've started a background task. You'll receive a message in 3 seconds."
