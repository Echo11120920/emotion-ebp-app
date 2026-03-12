#!/bin/bash

# 监控下载任务，完成后恢复睡眠
LOG_FILE="$HOME/Downloads/暂停实验室_EBP/download_monitor.log"

# 记录开始时间
echo "[$(date)] 开始监控下载任务..." >> "$LOG_FILE"

# 循环检查子代理状态
while true; do
    # 检查子代理是否还在运行
    STATUS=$(openclaw subagents list 2>/dev/null | grep "download_ebp_files" | grep -c "running" || echo "0")
    
    if [ "$STATUS" = "0" ]; then
        # 下载完成
        echo "[$(date)] 下载任务完成！" >> "$LOG_FILE"
        
        # 整理文件
        echo "[$(date)] 整理文件中..." >> "$LOG_FILE"
        ls -la "$HOME/Downloads/暂停实验室_EBP/" >> "$LOG_FILE" 2>&1
        
        # 发送通知（如果配置了）
        echo "[$(date)] 所有文件下载完成！可以上传到飞书了。" >> "$LOG_FILE"
        
        # 退出 caffeinate（允许睡眠）
        echo "[$(date)] 恢复系统正常睡眠模式" >> "$LOG_FILE"
        
        # 结束 caffeinate 进程
        pkill -f "caffeinate.*openclaw"
        
        break
    fi
    
    # 每 30 秒检查一次
    sleep 30
done

echo "[$(date)] 监控脚本结束" >> "$LOG_FILE"