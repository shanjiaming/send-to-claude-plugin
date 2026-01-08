---
name: send-message
description: Send a message to yourself for testing callbacks
args: <message>
---

Send a test message to the current Claude session to verify callback functionality.

This skill demonstrates the callback mechanism by immediately sending a message back to Claude. Useful for:
- Testing if the send-to-claude script is properly installed
- Demonstrating self-messaging capabilities
- Debugging callback issues

## Usage

```
/send-message "Hello from the future!"
```

## How It Works

1. Detects your current terminal environment (tmux or iTerm2)
2. Calls the `send-to-claude` script
3. The message appears as if you typed it manually
4. Claude processes it as user input

## Example Use Cases

**Test installation:**
```
/send-message "Installation test"
```

**Simulate async callback:**
```
Start a background task, then use this to see what a callback looks like
/send-message "Task completed!"
```

**Self-restart trigger:**
```
/send-message "/exit"
```

## Implementation

Execute the following command:

```bash
send-to-claude "$ARGUMENTS"
```

The `$ARGUMENTS` variable contains the message text provided by the user.
