# SECURITY.md - 安全提醒

## 当前安全级别：轻度保护

### ✅ 已配置
- Telegram：仅限用户 ID 8722758973（Echo Zhang）
- Web Chat：仅本机访问（127.0.0.1）
- 敏感操作：需要询问确认

### ⚠️ 注意事项

**我可以直接访问的目录：**
- `~/.openclaw/workspace/` — 工作目录，完全访问
- `~/Downloads/` — 读取（删除需确认）
- `~/Documents/` — 读取（删除需确认）

**需要确认的操作：**
- 删除任何文件
- 发送外部消息
- 系统级命令
- 敏感目录访问

**如果怀疑安全问题：**
1. 立即停止 Gateway：`openclaw gateway stop`
2. 检查最近操作：`openclaw logs --follow`
3. 撤销 Telegram 权限：删除 `channels.telegram` 配置

---

最后更新：2026-03-09
