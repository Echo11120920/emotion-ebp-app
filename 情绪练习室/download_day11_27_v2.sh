#!/bin/bash

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

download_audio() {
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
    
    # 尝试 lh.v2 (正念)
    if [ "$type" = "listen" ]; then
        curl -L --max-time 30 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.${type}.day${day}.lh.v2.mp3" 2>/dev/null
        local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            local mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ 完成: $filename (${mb}MB, lh.v2)"
            return 0
        fi
        rm -f "$output"
    fi
    
    # 尝试 gyz.v2 (正念备选)
    if [ "$type" = "listen" ]; then
        curl -L --max-time 30 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.${type}.day${day}.gyz.v2.mp3" 2>/dev/null
        local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            local mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ 完成: $filename (${mb}MB, gyz.v2)"
            return 0
        fi
        rm -f "$output"
    fi
    
    # 尝试阅读音频 v3/v2
    if [ "$type" = "read" ]; then
        for version in v3 v2 v4; do
            curl -L --max-time 30 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.${type}.day${day}.${version}.mp3" 2>/dev/null
            local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
            if [ "$size" -gt 10000 ]; then
                local mb=$(echo "scale=2; $size/1024/1024" | bc)
                echo "✓ 完成: $filename (${mb}MB, $version)"
                return 0
            fi
            rm -f "$output"
        done
    fi
    
    echo "✗ 失败: $filename"
    return 1
}

echo "下载 Day 11-27 音频..."

for day in 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27; do
    download_audio "$day" "read" "day${day}_read.mp3"
    download_audio "$day" "listen" "day${day}_listen.mp3"
done

echo "Day 11-27 完成！"