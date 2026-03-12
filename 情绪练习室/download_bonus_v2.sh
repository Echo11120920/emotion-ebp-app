#!/bin/bash

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

echo "尝试更多URL模式下载彩蛋音频..."

download_bonus_v2() {
    local day=$1
    local type=$2
    local filename="day${day}_${type}.mp3"
    local output="$AUDIO_DIR/$filename"
    
    if [ -f "$output" ]; then
        local size=$(stat -f%z "$output" 2>/dev/null)
        if [ "$size" -gt 10000 ]; then
            echo "✓ 已存在: $filename"
            return 0
        fi
    fi
    
    # 尝试更多变体
    for prefix in ebp.emotion.base ebp; do
        for v in v1 v2 v3 v4 v5; do
            curl -L --max-time 15 -o "$output" "https://static.gesedna.com/audios/${prefix}.${type}.day${day}.${v}.mp3" 2>/dev/null
            local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
            if [ "$size" -gt 10000 ]; then
                local mb=$(echo "scale=2; $size/1024/1024" | bc)
                echo "✓ $filename (${mb}MB, ${prefix}.${v})"
                return 0
            fi
            rm -f "$output"
        done
    done
    
    # 尝试彩蛋专用路径
    for v in v1 v2 v3; do
        curl -L --max-time 15 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.bonus.${type}.day${day}.${v}.mp3" 2>/dev/null
        local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            local mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ $filename (${mb}MB, bonus.${v})"
            return 0
        fi
        rm -f "$output"
    done
    
    # 尝试不同的主讲人组合
    for instructor in lh gyz lhx wcx; do
        for v in v1 v2 v3; do
            curl -L --max-time 15 -o "$output" "https://static.gesedna.com/audios/ebp.emotion.base.${type}.day${day}.${instructor}.${v}.mp3" 2>/dev/null
            local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
            if [ "$size" -gt 10000 ]; then
                local mb=$(echo "scale=2; $size/1024/1024" | bc)
                echo "✓ $filename (${mb}MB, ${instructor}.${v})"
                return 0
            fi
            rm -f "$output"
        done
    done
    
    echo "✗ $filename"
    return 1
}

# 下载 Day 22-27
for day in 22 23 24 25 26 27; do
    download_bonus_v2 "$day" "read"
    download_bonus_v2 "$day" "listen"
done

echo "彩蛋音频补充完成！"