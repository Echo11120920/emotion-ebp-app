#!/bin/bash

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

echo "尝试替代路径下载剩余音频..."

# 尝试不同的基础URL路径
try_download() {
    local day=$1
    local type=$2
    local filename="day${day}_${type}.mp3"
    local output="$AUDIO_DIR/$filename"
    
    if [ -f "$output" ]; then
        local size=$(stat -f%z "$output" 2>/dev/null)
        if [ "$size" -gt 10000 ]; then
            return 0
        fi
    fi
    
    # 尝试不同的路径前缀
    for prefix in "audios" "audio" "files" "media"; do
        for v in v1 v2 v3; do
            curl -L --max-time 15 -o "$output" "https://static.gesedna.com/${prefix}/ebp.emotion.base.${type}.day${day}.${v}.mp3" 2>/dev/null
            local size=$(stat -f%z "$output" 2>/dev/null || echo 0)
            if [ "$size" -gt 10000 ]; then
                local mb=$(echo "scale=2; $size/1024/1024" | bc)
                echo "✓ $filename (${mb}MB, ${prefix}.${v})"
                return 0
            fi
            rm -f "$output"
        done
    done
    
    return 1
}

# 尝试Day 8阅读
try_download "8" "read"

# 尝试Day 22-27
for day in 22 23 25 26 27; do
    try_download "$day" "read"
    try_download "$day" "listen"
done

# 尝试Day 24阅读
try_download "24" "read"

echo "替代路径尝试完成！"