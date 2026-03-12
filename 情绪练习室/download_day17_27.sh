#!/bin/bash

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

echo "下载 Day 17-27 音频..."

for day in 17 18 19 20 21 22 23 24 25 26 27; do
    # 阅读音频
    curl -L --max-time 60 -o "$AUDIO_DIR/day${day}_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day${day}.v3.mp3" 2>/dev/null
    size=$(stat -f%z "$AUDIO_DIR/day${day}_read.mp3" 2>/dev/null || echo 0)
    if [ "$size" -gt 10000 ]; then
        echo "✓ day${day}_read"
    else
        rm -f "$AUDIO_DIR/day${day}_read.mp3"
        curl -L --max-time 60 -o "$AUDIO_DIR/day${day}_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day${day}.v2.mp3" 2>/dev/null
        size=$(stat -f%z "$AUDIO_DIR/day${day}_read.mp3" 2>/dev/null || echo 0)
        if [ "$size" -gt 10000 ]; then
            echo "✓ day${day}_read (v2)"
        else
            rm -f "$AUDIO_DIR/day${day}_read.mp3"
            echo "✗ day${day}_read"
        fi
    fi
    
    # 正念音频
    curl -L --max-time 60 -o "$AUDIO_DIR/day${day}_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day${day}.gyz.v2.mp3" 2>/dev/null
    size=$(stat -f%z "$AUDIO_DIR/day${day}_listen.mp3" 2>/dev/null || echo 0)
    if [ "$size" -gt 10000 ]; then
        echo "✓ day${day}_listen"
    else
        rm -f "$AUDIO_DIR/day${day}_listen.mp3"
        echo "✗ day${day}_listen"
    fi
done

echo "Day 17-27 完成！"