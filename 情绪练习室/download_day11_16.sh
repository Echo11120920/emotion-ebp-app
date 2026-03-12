#!/bin/bash

# 尝试使用不同方式下载音频

AUDIO_DIR="/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/audio"

echo "尝试下载 Day 11-27 的音频..."

# Day 11
curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day11_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day11.v3.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day11_read.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day11_read.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day11_read" || { rm -f "$AUDIO_DIR/day11_read.mp3"; curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day11_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day11.v2.mp3" 2>/dev/null && echo "✓ day11_read (v2)" || rm -f "$AUDIO_DIR/day11_read.mp3"; }

curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day11_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day11.gyz.v2.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day11_listen.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day11_listen.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day11_listen" || rm -f "$AUDIO_DIR/day11_listen.mp3"

# Day 12
curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day12_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day12.v3.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day12_read.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day12_read.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day12_read" || rm -f "$AUDIO_DIR/day12_read.mp3"

curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day12_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day12.gyz.v2.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day12_listen.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day12_listen.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day12_listen" || rm -f "$AUDIO_DIR/day12_listen.mp3"

# Day 13
curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day13_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day13.v3.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day13_read.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day13_read.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day13_read" || rm -f "$AUDIO_DIR/day13_read.mp3"

curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day13_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day13.gyz.v2.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day13_listen.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day13_listen.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day13_listen" || rm -f "$AUDIO_DIR/day13_listen.mp3"

# Day 14
curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day14_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day14.v3.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day14_read.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day14_read.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day14_read" || rm -f "$AUDIO_DIR/day14_read.mp3"

curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day14_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day14.gyz.v2.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day14_listen.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day14_listen.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day14_listen" || rm -f "$AUDIO_DIR/day14_listen.mp3"

# Day 15
curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day15_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day15.v3.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day15_read.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day15_read.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day15_read" || rm -f "$AUDIO_DIR/day15_read.mp3"

curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day15_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day15.gyz.v2.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day15_listen.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day15_listen.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day15_listen" || rm -f "$AUDIO_DIR/day15_listen.mp3"

# Day 16
curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day16_read.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.read.day16.v3.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day16_read.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day16_read.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day16_read" || rm -f "$AUDIO_DIR/day16_read.mp3"

curl -L -H "User-Agent: Mozilla/5.0" --max-time 60 -o "$AUDIO_DIR/day16_listen.mp3" "https://static.gesedna.com/audios/ebp.emotion.base.listen.day16.gyz.v2.mp3" 2>/dev/null
[ -f "$AUDIO_DIR/day16_listen.mp3" ] && [ $(stat -f%z "$AUDIO_DIR/day16_listen.mp3" 2>/dev/null) -gt 10000 ] && echo "✓ day16_listen" || rm -f "$AUDIO_DIR/day16_listen.mp3"

echo "Day 11-16 完成！"