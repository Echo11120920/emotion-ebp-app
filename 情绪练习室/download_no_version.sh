#!/bin/bash

# 批量下载剩余音频（基于无版本号URL模式）

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

echo "尝试无版本号URL模式下载..."

# Day 22-27阅读（无版本号格式）
for day in 22 23 24 25 26 27; do
    if [ ! -f "$AUDIO_DIR/day${day}_read.mp3" ]; then
        curl -L --max-time 30 -o "$AUDIO_DIR/day${day}_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day${day}.mp3" 2>/dev/null
        size=$(stat -f%z "$AUDIO_DIR/day${day}_read.mp3" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ day${day}_read (${mb}MB)"
        else
            rm -f "$AUDIO_DIR/day${day}_read.mp3"
            echo "✗ day${day}_read"
        fi
    fi
done

# Day 23-27正念（尝试各种组合）
for day in 23 25 26 27; do
    if [ ! -f "$AUDIO_DIR/day${day}_listen.mp3" ]; then
        # 尝试 dayXX.lh.v1
        curl -L --max-time 30 -o "$AUDIO_DIR/day${day}_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day${day}.lh.v1.mp3" 2>/dev/null
        size=$(stat -f%z "$AUDIO_DIR/day${day}_listen.mp3" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ day${day}_listen (${mb}MB, lh.v1)"
            continue
        fi
        rm -f "$AUDIO_DIR/day${day}_listen.mp3"
        
        # 尝试 dayXX.gyz.v1
        curl -L --max-time 30 -o "$AUDIO_DIR/day${day}_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day${day}.gyz.v1.mp3" 2>/dev/null
        size=$(stat -f%z "$AUDIO_DIR/day${day}_listen.mp3" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "✓ day${day}_listen (${mb}MB, gyz.v1)"
            continue
        fi
        rm -f "$AUDIO_DIR/day${day}_listen.mp3"
        
        echo "✗ day${day}_listen"
    fi
done

# Day 24阅读
curl -L --max-time 30 -o "$AUDIO_DIR/day24_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day24.mp3" 2>/dev/null
size=$(stat -f%z "$AUDIO_DIR/day24_read.mp3" 2>/dev/null || echo 0)
if [ "$size" -gt 10000 ]; then
    mb=$(echo "scale=2; $size/1024/1024" | bc)
    echo "✓ day24_read (${mb}MB)"
else
    rm -f "$AUDIO_DIR/day24_read.mp3"
    echo "✗ day24_read"
fi

echo "完成！"