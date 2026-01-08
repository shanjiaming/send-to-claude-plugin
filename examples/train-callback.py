#!/usr/bin/env python3
"""
Example: ML training with progress callbacks to Claude Code

Demonstrates:
- Reporting progress during training
- Notifying on completion
- Handling errors with callbacks
"""

import os
import time
import random


def send_to_claude(message):
    """Helper to send messages to Claude"""
    os.system(f'send-to-claude "{message}"')


def train_epoch(epoch):
    """Simulate training one epoch"""
    print(f"Training epoch {epoch}...")
    time.sleep(2)  # Simulate training time
    accuracy = 0.5 + (epoch * 0.01) + random.uniform(-0.02, 0.02)
    return accuracy


def main():
    total_epochs = 20

    # Start notification
    send_to_claude(f"🚀 Starting training for {total_epochs} epochs")

    try:
        for epoch in range(1, total_epochs + 1):
            accuracy = train_epoch(epoch)

            # Report progress every 5 epochs
            if epoch % 5 == 0:
                progress = (epoch / total_epochs) * 100
                send_to_claude(
                    f"📊 Progress: {progress:.0f}% | "
                    f"Epoch {epoch}/{total_epochs} | "
                    f"Accuracy: {accuracy:.2%}"
                )

        # Final notification
        send_to_claude(
            f"✅ Training complete! Final accuracy: {accuracy:.2%}"
        )

    except KeyboardInterrupt:
        send_to_claude("⚠️ Training interrupted by user")
    except Exception as e:
        send_to_claude(f"❌ Training failed: {str(e)}")


if __name__ == "__main__":
    main()
