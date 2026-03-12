// 批量抓取阅读内容的脚本
// 在浏览器控制台运行

const dayTitles = {
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

// 抓取函数
async function scrapeAllDays() {
  const results = [];
  
  for (let day = 4; day <= 21; day++) {
    const url = `https://ebp.gesedna.com/EBPModule/ebp.emotion.base.read.${day}?available=0&package_id=emotion_base&rd=%2FPackageList%2Femotion_base%2F1.0%2F%3Frd%3D%252FDashboard%252F`;
    
    // 打开页面
    window.open(url, '_blank');
    
    console.log(`已打开 Day ${day}: ${dayTitles[day]}`);
    console.log(`请等待页面加载，然后运行抓取代码...`);
    
    // 等待用户手动抓取
    await new Promise(resolve => setTimeout(resolve, 3000));
  }
}

console.log('运行 scrapeAllDays() 开始批量抓取');
console.log('或者手动访问以下URL:');
for (let day = 4; day <= 21; day++) {
  console.log(`Day ${day}: https://ebp.gesedna.com/EBPModule/ebp.emotion.base.read.${day}`);
}