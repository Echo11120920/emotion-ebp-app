#!/bin/bash

# 批量抓取阅读内容的Node.js脚本
# 需要在浏览器环境中运行

cat > /tmp/scrape_all.js << 'EOF'
const fs = require('fs');
const path = require('path');

const contentDir = '/Users/zhangxiaoqian/.openclaw/workspace/情绪练习室/content';

// 每天的标题映射
const dayTitles = {
  1: "欢迎探索情绪的世界",
  2: "感知与识别你的情绪",
  3: "理解情绪——基本规律",
  4: "理解情绪——寻找为什么",
  5: "感知与理解情绪小结",
  6: "重新认识情绪调节",
  7: "应对情绪失控",
  8: "运用身体反应",
  9: "识别与调整自动化想法",
  10: "掌控注意力应对思绪游离",
  11: "提升自主感直面压力挑战",
  12: "情绪调节小结",
  13: "识别沟通风格",
  14: "自信而坚定地表达需求",
  15: "了解对方需求",
  16: "应对冲突促进合作",
  17: "运用情绪智能基础思路",
  18: "与焦虑同行",
  19: "应对悲伤低落",
  20: "应对愤怒",
  21: "持续练习提升情绪智能"
};

// 生成抓取脚本
let script = `
// 在浏览器控制台运行此脚本抓取所有阅读内容
// 复制以下内容到浏览器控制台

const dayTitles = ${JSON.stringify(dayTitles, null, 2)};
const results = [];

async function scrapeDay(day) {
  const url = \`https://ebp.gesedna.com/EBPModule/ebp.emotion.base.read.\${day}?available=0&package_id=emotion_base&rd=%2FPackageList%2Femotion_base%2F1.0%2F%3Frd%3D%252FDashboard%252F\`;
  
  // 这里需要手动访问每个页面并抓取内容
  console.log(\`Day \${day}: \${dayTitles[day]}\`);
  console.log(\`URL: \${url}\`);
  
  // 实际抓取代码需要在每个页面运行
  const content = document.body.innerText;
  return {
    day: day,
    title: dayTitles[day],
    content: content
  };
}

console.log('请按顺序访问以下URL并抓取内容:');
for (let day = 1; day <= 21; day++) {
  console.log(\`\${day}. Day \${day}: https://ebp.gesedna.com/EBPModule/ebp.emotion.base.read.\${day}\`);
}
`;

console.log('抓取脚本已生成');
console.log('由于需要登录状态，请手动访问每个页面并复制内容');
console.log('');
console.log('需要抓取的页面:');
for (let day = 1; day <= 21; day++) {
  console.log(`Day ${day}: ${dayTitles[day]}`);
}
EOF

node /tmp/scrape_all.js

echo ""
echo "由于浏览器限制，我将逐个页面抓取内容..."
echo "请稍等，这需要一些时间..."