#!/bin/bash

# 监控所有下载任务，完成后恢复睡眠
LOG_FILE="$HOME/Downloads/暂停实验室_EBP/download_monitor.log"

# 记录开始时间
echo "[$(date)] 开始监控所有下载任务..." >> "$LOG_FILE"
echo "[$(date)] 任务列表：情绪EBP、CBT综合、自我关怀" >> "$LOG_FILE"

# 循环检查子代理状态
while true; do
    # 检查所有子代理状态
    RUNNING_COUNT=$(openclaw subagents list 2>/dev/null | grep -c "running" || echo "0")
    
    echo "[$(date)] 当前运行中的任务数: $RUNNING_COUNT" >> "$LOG_FILE"
    
    if [ "$RUNNING_COUNT" = "0" ]; then
        # 所有下载完成
        echo "[$(date)] ===================================" >> "$LOG_FILE"
        echo "[$(date)] 所有下载任务完成！" >> "$LOG_FILE"
        echo "[$(date)] ===================================" >> "$LOG_FILE"
        
        # 整理文件 - 情绪EBP
        echo "[$(date)] --- 情绪EBP 文件 ---" >> "$LOG_FILE"
        find "$HOME/Downloads/暂停实验室_EBP/" -maxdepth 2 -type f 2>/dev/null | head -20 >> "$LOG_FILE"
        
        # 整理文件 - CBT
        echo "[$(date)] --- CBT综合 文件 ---" >> "$LOG_FILE"
        find "$HOME/Downloads/暂停实验室_EBP/CBT综合/" -maxdepth 2 -type f 2>/dev/null | head -20 >> "$LOG_FILE"
        
        # 整理文件 - 自我关怀
        echo "[$(date)] --- 自我关怀 文件 ---" >> "$LOG_FILE"
        find "$HOME/Downloads/暂停实验室_EBP/自我关怀/" -maxdepth 2 -type f 2>/dev/null | head -20 >> "$LOG_FILE"
        
        # 统计总数
        TOTAL_FILES=$(find "$HOME/Downloads/暂停实验室_EBP/" -type f 2>/dev/null | wc -l)
        echo "[$(date)] 总文件数: $TOTAL_FILES" >> "$LOG_FILE"
        
        echo "[$(date)] ===================================" >> "$LOG_FILE"
        echo "[$(date)] 所有文件下载完成！可以上传到飞书了。" >> "$LOG_FILE"
        echo "[$(date)] 文件位置: ~/Downloads/暂停实验室_EBP/" >> "$LOG_FILE"
        echo "[$(date)] ===================================" >> "$LOG_FILE"
        
        # 结束 caffeinate（允许睡眠）
        echo "[$(date)] 恢复系统正常睡眠模式" >> "$LOG_FILE"
        pkill -f "caffeinate.*openclaw" 2>/dev/null || true
        
        break
    fi
    
    # 每 60 秒检查一次
    sleep 60
done

echo "[$(date)] 监控脚本结束" >> "$LOG_FILE"