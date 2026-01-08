#!/bin/bash
# Example: Progress report with checkpoints

set -e

TOTAL_STEPS=10

echo "Starting long-running process..."
send-to-claude "🔄 Process started with $TOTAL_STEPS steps"

for i in $(seq 1 $TOTAL_STEPS); do
    echo "Step $i/$TOTAL_STEPS..."
    sleep 1

    # Report every 3 steps
    if [ $((i % 3)) -eq 0 ]; then
        progress=$((i * 100 / TOTAL_STEPS))
        send-to-claude "⏳ Progress: ${progress}% (step $i/$TOTAL_STEPS)"
    fi
done

send-to-claude "✅ All steps completed successfully!"
