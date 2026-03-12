#!/bin/bash

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

echo "尝试更多URL模式下载剩余音频..."

# 尝试Day 8阅读
echo "=== Day 8 阅读 ==="
for v in v1 v2 v3 v4 v5; do
    curl -L --max-time 20 -o "$AUDIO_DIR/day08_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day8.${v}.mp3" 2>/dev/null
    size=$(stat -f%z "$AUDIO_DIR/day08_read.mp3" 2>/dev/null || echo 0)
    if [ "$size" -gt 10000 ]; then
        mb=$(echo "scale=2; $size/1024/1024" | bc)
        echo "✓ day08_read (${mb}MB, ${v})"
        break
    fi
    rm -f "$AUDIO_DIR/day08_read.mp3"
done

# 尝试Day 22-27的各种模式
echo "=== Day 22-27 彩蛋音频 ==="

for day in 22 23 25 26 27; do
    echo "Day ${day}..."
    
    # 阅读音频
    for v in v1 v2 v3 v4 v5; do
        curl -L --max-time 15 -o "$AUDIO_DIR/day${day}_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day${day}.${v}.mp3" 2>/dev/null
        size=$(stat -f%z "$AUDIO_DIR/day${day}_read.mp3" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "  ✓ day${day}_read (${mb}MB, ${v})"
            break
        fi
        rm -f "$AUDIO_DIR/day${day}_read.mp3"
    done
    
    # 正念音频 - 尝试 lh
    curl -L --max-time 15 -o "$AUDIO_DIR/day${day}_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day${day}.lh.v1.mp3" 2>/dev/null
    size=$(stat -f%z "$AUDIO_DIR/day${day}_listen.mp3" 2>/dev/null || echo 0)
    if [ "$size" -gt 10000 ]; then
        mb=$(echo "scale=2; $size/1024/1024" | bc)
        echo "  ✓ day${day}_listen (${mb}MB, lh.v1)"
    else
        rm -f "$AUDIO_DIR/day${day}_listen.mp3"
        
        # 尝试 gyz
        curl -L --max-time 15 -o "$AUDIO_DIR/day${day}_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day${day}.gyz.v1.mp3" 2>/dev/null
        size=$(stat -f%z "$AUDIO_DIR/day${day}_listen.mp3" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            mb=$(echo "scale=2; $size/1024/1024" | bc)
            echo "  ✓ day${day}_listen (${mb}MB, gyz.v1)"
        else
            rm -f "$AUDIO_DIR/day${day}_listen.mp3"
            echo "  ✗ day${day}_listen"
        fi
    fi
done

# Day 24阅读
echo "=== Day 24 阅读 ==="
for v in v1 v2 v3; do
    curl -L --max-time 15 -o "$AUDIO_DIR/day24_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day24.${v}.mp3" 2>/dev/null
    size=$(stat -f%z "$AUDIO_DIR/day24_read.mp3" 2>/dev/null || echo 0)
    if [ "$size" -gt 10000 ]; then
        mb=$(echo "scale=2; $size/1024/1024" | bc)
        echo "✓ day24_read (${mb}MB, ${v})"
        break
    fi
    rm -f "$AUDIO_DIR/day24_read.mp3"
done

echo "剩余音频下载完成！"