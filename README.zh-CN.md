# Send to Claude - 让 Claude Code 实现真正的自主工作流

[English](README.md) | [中文](README.zh-CN.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![tmux](https://img.shields.io/badge/tmux-supported-brightgreen.svg)](https://github.com/tmux/tmux)
[![iTerm2](https://img.shields.io/badge/iTerm2-supported-brightgreen.svg)](https://iterm2.com/)

**Claude 现在可以给自己发消息来唤醒自己了。**

这个插件让 Claude 能够自主完成多步骤工作流，不再需要你回来继续。

## 系统要求

**Claude Code 必须运行在以下终端之一：**
- tmux
- iTerm2

插件会自动检测你的终端环境。

---

## 痛点

```
你：训练模型，完成后分析结果并生成报告
Claude：开始训练...
[10 分钟后训练完成]
Claude：（沉默）
你：（回来）训练完了吗？
Claude：完了！开始分析...
```

Claude 不知道后台任务何时完成，多步骤工作流在这里断了。

---

## 解决方案

让 Claude 给自己发消息：

```python
# Claude 写的训练脚本
import os

train_model()  # 训练 10 分钟

# 完成后唤醒自己
os.system('send-to-claude "训练完成！准确率 94%，开始分析..."')
```

当脚本跑完，**Claude 的输入框自动出现这条消息**，Claude 被唤醒，继续工作。

**还可以实现定时轮询**：每小时检查邮件、每 4 小时触发睡眠机制、定期整理记忆等。

---

## 工作原理

1. Claude 运行在 tmux/iTerm2 里，有环境变量 `$TMUX` 或 `$ITERM_SESSION_ID`
2. Claude 创建的脚本继承这些环境变量
3. 脚本调用 `send-to-claude` → 通过环境变量找到 Claude 的 session
4. 发送消息到 Claude 的终端输入

技术实现：
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

## 安装

在 Claude Code 中：
```
/plugin marketplace add https://github.com/shanjiaming/send-to-claude-plugin
/plugin install send-to-claude
```

然后运行这个命令完成安装：
```bash
bash ~/.claude/plugins/cache/send-to-claude/send-to-claude/0.1.0/install.sh
```

确保 `~/.local/bin` 在你的 PATH 中。

卸载：
```bash
bash ~/.claude/plugins/cache/send-to-claude/send-to-claude/0.1.0/uninstall.sh
```

---

## 使用

直接给 Claude 多步骤任务：

```
"训练模型，然后分析结果"
"处理 1000 个文件，每 100 个报告进度"
"下载数据，清洗，训练，部署"
```

Claude 自动在脚本里加回调，自主完成。

测试：对 Claude 说 "Test the callback mechanism"

---

## 对比 Background Agents

| 特性 | send-to-claude | Background Agents |
|------|----------------|-------------------|
| 任务完成通知 | ✅ | ✅ |
| 任意时刻回调 | ✅ | ❌ 只有完成时 |
| Claude 自主继续 | ✅ | ❌ 需要用户 |
| 多步骤自动化 | ✅ | ❌ 每步需要用户 |
| 定时轮询 | ✅ | ❌ |

---

## 技术细节

**为什么不轮询？**

轮询占用 session、浪费 token、无法处理其他任务。

回调机制：Claude 释放资源，任务完成时精确唤醒，等待时零消耗。

**环境变量为什么能工作？**

Unix 子进程继承父进程环境变量：

```
Claude (tmux, 有 $TMUX)
  └─ python train.py (继承 $TMUX)
       └─ os.system('send-to-claude') (继承 $TMUX)
            └─ 读取 $TMUX，找到 Claude session
```

---

## 总结

这个插件让 Claude 从"被动响应"变成"主动持续工作"。

装上之后：
- 不用盯着进度
- 不用回来说"继续"
- 不用手动串步骤

**Claude 真的能自己工作了。**

---

## License

MIT License - see [LICENSE](LICENSE)
