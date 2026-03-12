// 抓取所有音频URL的脚本
// 在浏览器控制台运行

const audioUrls = [];

// 遍历所有天数
for (let day = 0; day <= 27; day++) {
    const dayItem = document.querySelector(`[ref=e${38 + day * 10}]`);
    if (!dayItem) continue;
    
    const links = dayItem.querySelectorAll('a');
    links.forEach(link => {
        const url = link.getAttribute('href');
        const title = link.textContent.trim();
        
        if (url && url.includes('EBPModule')) {
            const type = url.includes('read') ? 'read' : 
                        url.includes('listen') ? 'listen' : 
                        url.includes('write') ? 'write' : 'other';
            
            audioUrls.push({
                day: day,
                type: type,
                title: title,
                url: url
            });
        }
    });
}

console.log('找到 ' + audioUrls.length + ' 个练习链接');
console.log(audioUrls);

// 复制到剪贴板
copy(JSON.stringify(audioUrls, null, 2));
console.log('已复制到剪贴板');