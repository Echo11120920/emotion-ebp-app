#!/bin/bash

# 情绪EBP音频批量下载脚本

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"
LOG_FILE="$AUDIO_DIR/download.log"

echo "[$(date)] 开始下载音频文件..." > "$LOG_FILE"

# 下载函数
download_audio() {
    local url=$1
    local filename=$2
    local output="$AUDIO_DIR/$filename"
    
    if [ -f "$output" ]; then
        local size=$(stat -f%z "$output" 2>/dev/null || stat -c%s "$output" 2>/dev/null)
        echo "✓ 已存在: $filename (${size} bytes)"
        return 0
    fi
    
    echo "⬇️ 下载: $filename"
    curl -L --max-time 120 -o "$output" "$url" 2>/dev/null
    
    if [ -f "$output" ]; then
        local size=$(stat -f%z "$output" 2>/dev/null || stat -c%s "$output" 2>/dev/null)
        if [ "$size" -gt 10000 ]; then
            local mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ 完成: $filename (${mb}MB)" | tee -a "$LOG_FILE"
            return 0
        else
            rm -f "$output"
            echo "✗ 失败: $filename (文件太小)" | tee -a "$LOG_FILE"
            return 1
        fi
    else
        echo "✗ 失败: $filename" | tee -a "$LOG_FILE"
        return 1
    fi
}

# Day 0
download_audio "https://ebp.gesedna.com/EBPModule/ebp.guidevideo" "day00_guide.mp3"

# Day 1
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day1.v3.mp3" "day01_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day1.gyz.v2.mp3" "day01_listen.mp3"

# Day 2
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day2.v3.mp3" "day02_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day2.gyz.v2.mp3" "day02_listen.mp3"

# Day 3
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day3.v3.mp3" "day03_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day3.gyz.v2.mp3" "day03_listen.mp3"

# Day 4
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day4.v3.mp3" "day04_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day4.gyz.v2.mp3" "day04_listen.mp3"

# Day 5
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day5.v3.mp3" "day05_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day5.gyz.v2.mp3" "day05_listen.mp3"

# Day 6
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day6.v3.mp3" "day06_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day6.gyz.v2.mp3" "day06_listen.mp3"

# Day 7
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day7.v3.mp3" "day07_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day7.gyz.v2.mp3" "day07_listen.mp3"

# Day 8
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day8.v3.mp3" "day08_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day8.gyz.v2.mp3" "day08_listen.mp3"

# Day 9
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day9.v3.mp3" "day09_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day9.gyz.v2.mp3" "day09_listen.mp3"

# Day 10
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.read.day10.v3.mp3" "day10_read.mp3"
download_audio "https://static.gesedna.com/audios/ebp.emotion.base.listen.day10.gyz.v2.mp3" "day10_listen.mp3"

echo ""
echo "前11天音频下载完成！"
echo "[$(date)] 下载完成" >> "$LOG_FILE"