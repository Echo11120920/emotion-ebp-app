#!/bin/bash

# 尝试更多URL格式下载音频

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

# 尝试不同的主讲人缩写
instructors=("gyz" "lh" "lhx" "v2" "v3" "v4" "v5")

download_with_all_patterns() {
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
    
    # 尝试不同的版本
    for version in v3 v2 v4 v5; do
        local url="https://static.gesedna.com/audios/ebp.emotion.base.${type}.day${day}.${version}.mp3"
        curl -L --max-time 30 -o "$output" "$url" 2>/dev/null
        local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            local mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ 完成: $filename (${mb}MB, $version)"
            return 0
        fi
        rm -f "$output"
    done
    
    # 尝试不同的主讲人
    for instructor in gyz lh lhx; do
        for version in v2 v3 v4 v5; do
            local url="https://static.gesedna.com/audios/ebp.emotion.base.${type}.day${day}.${instructor}.${version}.mp3"
            curl -L --max-time 30 -o "$output" "$url" 2>/dev/null
            local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
            if [ "$size" -gt 10000 ]; then
                local mb=$(echo "scale=2; $size/1024/1024" | bc)
                echo "✓ 完成: $filename (${mb}MB, ${instructor}.${version})"
                return 0
            fi
            rm -f "$output"
        done
    done
    
    echo "✗ 失败: $filename"
    return 1
}

echo "尝试下载缺失的音频（使用更多URL模式）..."

# Day 3
download_with_all_patterns "3" "read" "day03_read.mp3"
download_with_all_patterns "3" "listen" "day03_listen.mp3"

# Day 4
download_with_all_patterns "4" "read" "day04_read.mp3"
download_with_all_patterns "4" "listen" "day04_listen.mp3"

# Day 5
download_with_all_patterns "5" "listen" "day05_listen.mp3"

# Day 6
download_with_all_patterns "6" "read" "day06_read.mp3"

# Day 7
download_with_all_patterns "7" "listen" "day07_listen.mp3"

# Day 8
download_with_all_patterns "8" "read" "day08_read.mp3"
download_with_all_patterns "8" "listen" "day08_listen.mp3"

# Day 9
download_with_all_patterns "9" "read" "day09_read.mp3"

echo "Day 3-9 补充完成！"