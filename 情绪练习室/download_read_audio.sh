#!/bin/bash

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

echo "尝试更多URL模式下载阅读音频..."

# 尝试不同的命名模式
download_read() {
    local day=$1
    local output="$AUDIO_DIR/day${day}_read.mp3"
    
    if [ -f "$output" ]; then
        local size=$(stat -f%z "$output" 2>/dev/null)
        if [ "$size" -gt 10000 ]; then
            echo "✓ 已存在: day${day}_read.mp3"
            return 0
        fi
    fi
    
    # 模式1: 直接版本号
    for v in v5 v4 v3 v2 v1; do
        curl -L --max-time 20 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.read.day${day}.${v}.mp3" 2>/dev/null
        local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            local mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ day${day}_read (${mb}MB, ${v})"
            return 0
        fi
        rm -f "$output"
    done
    
    # 模式2: 带主讲人缩写
    for instructor in lhx lh gyz wcx; do
        for v in v5 v4 v3 v2 v1; do
            curl -L --max-time 20 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.read.day${day}.${instructor}.${v}.mp3" 2>/dev/null
            local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
            if [ "$size" -gt 10000 ]; then
                local mb=$(echo "scale=2; $size/1024/1024" | bc)
                echo "✓ day${day}_read (${mb}MB, ${instructor}.${v})"
                return 0
            fi
            rm -f "$output"
        done
    done
    
    # 模式3: 不同的路径
    curl -L --max-time 20 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.read.${day}.v3.mp3" 2>/dev/null
    local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
    if [ "$size" -gt 10000 ]; then
        local mb=$(echo "scale=2; $size/1024/1024" | bc)
        echo "✓ day${day}_read (${mb}MB, alt path)"
        return 0
    fi
    rm -f "$output"
    
    echo "✗ day${day}_read"
    return 1
}

# 下载缺失的阅读音频
for day in 03 04 06 08 09 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27; do
    download_read "$day"
done

echo "阅读音频补充完成！"