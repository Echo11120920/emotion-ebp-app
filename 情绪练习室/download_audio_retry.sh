#!/bin/bash

# 情绪EBP音频下载 - 尝试多种URL格式

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"
LOG_FILE="$AUDIO_DIR/download.log"

echo "[$(date)] 开始下载剩余音频..." >> "$LOG_FILE"

download_with_retry() {
    local day=$1
    local type=$2
    local filename=$3
    local output="$AUDIO_DIR/$filename"
    
    if [ -f "$output" ]; then
        local size=$(stat -f%z "$output" 2>/dev/null)
        if [ "$size" -gt 10000 ]; then
            echo "✓ 已存在: $filename"
            return 0
        fi
    fi
    
    # 尝试 v3 版本
    echo "⬇️ 尝试 v3: $filename"
    curl -L --max-time 60 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.${type}.day${day}.v3.mp3" 2>/dev/null
    local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
    if [ "$size" -gt 10000 ]; then
        local mb=$(echo "scale=2; $size/1024/1024" | bc)
        echo "✓ 完成 (v3): $filename (${mb}MB)"
        return 0
    fi
    rm -f "$output"
    
    # 尝试 v2 版本
    echo "⬇️ 尝试 v2: $filename"
    curl -L --max-time 60 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.${type}.day${day}.v2.mp3" 2>/dev/null
    local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
    if [ "$size" -gt 10000 ]; then
        local mb=$(echo "scale=2; $size/1024/1024" | bc)
        echo "✓ 完成 (v2): $filename (${mb}MB)"
        return 0
    fi
    rm -f "$output"
    
    echo "✗ 失败: $filename"
    return 1
}

# Day 2 阅读
download_with_retry "2" "read" "day02_read.mp3"

# Day 3
download_with_retry "3" "read" "day03_read.mp3"
download_with_retry "3" "listen" "day03_listen.mp3"

# Day 4
download_with_retry "4" "read" "day04_read.mp3"
download_with_retry "4" "listen" "day04_listen.mp3"

# Day 5 正念
download_with_retry "5" "listen" "day05_listen.mp3"

# Day 6 阅读
download_with_retry "6" "read" "day06_read.mp3"

# Day 7
download_with_retry "7" "read" "day07_read.mp3"
download_with_retry "7" "listen" "day07_listen.mp3"

# Day 8
download_with_retry "8" "read" "day08_read.mp3"
download_with_retry "8" "listen" "day08_listen.mp3"

# Day 9 阅读
download_with_retry "9" "read" "day09_read.mp3"

# Day 10 阅读
download_with_retry "10" "read" "day10_read.mp3"

echo ""
echo "Day 2-10 补充下载完成！"
echo "[$(date)] Day 2-10 补充完成" >> "$LOG_FILE"