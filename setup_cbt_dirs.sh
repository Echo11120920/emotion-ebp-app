#!/bin/bash
# Download CBT course files

BASE_DIR="$HOME/Downloads/暂停实验室_EBP/CBT综合"
mkdir -p "$BASE_DIR"

# Day 0 - Introduction
cd "$BASE_DIR"
mkdir -p "Day00_启动攻略"
mkdir -p "Day00_CBT综合练习导览"
mkdir -p "Day00_书写_我的初心与承诺"

# Days 1-21
cd "$BASE_DIR"
for i in {1..21}; do
    mkdir -p "Day$(printf %02d $i)"
done

# Days 22-25 - Daily Practice
cd "$BASE_DIR"
for i in {22..25}; do
    mkdir -p "Day$(printf %02d $i)_日常练习"
done

# Days 26-27 - Bonus
cd "$BASE_DIR"
mkdir -p "Day26_彩蛋_探索中间信念与核心信念"
mkdir -p "Day27_彩蛋_撕掉身上的标签"

# Tools
cd "$BASE_DIR"
mkdir -p "Tools_情绪小锦囊"
mkdir -p "Tools_书写模板下载"

echo "Directory structure created successfully"
