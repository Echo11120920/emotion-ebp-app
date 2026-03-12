#!/bin/bash

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

echo "尝试下载早期缺失的阅读音频 (Day 3,4,6,8,9)..."

download_early_read() {
    local day=$1
    local output="$AUDIO_DIR/day0${day}_read.mp3"
    
    if [ -f "$output" ]; then
        local size=$(stat -f%z "$output" 2>/dev/null)
        if [ "$size" -gt 10000 ]; then
            echo "✓ 已存在: day0${day}_read.mp3"
            return 0
        fi
    fi
    
    # 尝试 v1 (之前成功的模式)
    curl -L --max-time 20 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.read.day${day}.v1.mp3" 2>/dev/null
    local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
    if [ "$size" -gt 10000 ]; then
        local mb=$(echo "scale=2; $size/1024/1024" | bc)
        echo "✓ day0${day}_read (${mb}MB, v1)"
        return 0
    fi
    rm -f "$output"
    
    # 尝试带主讲人的 v1
    for instructor in lh gyz lhx; do
        curl -L --max-time 20 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.read.day${day}.${instructor}.v1.mp3" 2>/dev/null
        local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            local mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ day0${day}_read (${mb}MB, ${instructor}.v1)"
            return 0
        fi
        rm -f "$output"
    done
    
    echo "✗ day0${day}_read"
    return 1
}

# 尝试下载早期缺失的阅读音频
for day in 3 4 6 8 9; do
    download_early_read "$day"
done

echo "早期阅读音频补充完成！"