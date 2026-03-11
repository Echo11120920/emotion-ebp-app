
const fs = require('fs');
const path = require('path');

// --- Configuration ---
const R2_PUBLIC_URL = 'https://pub-fe7f2c70ab5a4168a971de6d441975a6.r2.dev';
const AUDIO_DIR = path.join(__dirname, '..', 'audio');
const DATA_FILE = path.join(__dirname, '..', '..', 'frontend', 'src', 'data', 'course-data.json');
// --- End Configuration ---

console.log('Starting URL update process...');
console.log(`Audio directory: ${AUDIO_DIR}`);
console.log(`Data file: ${DATA_FILE}`);

// 1. Read all audio file names from the directory
let audioFiles;
try {
    audioFiles = fs.readdirSync(AUDIO_DIR).filter(f => f.endsWith('.mp3'));
    console.log(`Found ${audioFiles.length} audio files.`);
} catch (error) {
    console.error(`Error reading audio directory: ${AUDIO_DIR}`, error);
    process.exit(1);
}

// 2. Read the course data JSON file
let courseData;
try {
    const rawData = fs.readFileSync(DATA_FILE, 'utf8');
    courseData = JSON.parse(rawData);
    console.log('Successfully read and parsed course-data.json.');
} catch (error) {
    console.error(`Error reading or parsing data file: ${DATA_FILE}`, error);
    process.exit(1);
}

// 3. Create a map of existing audio files for quick lookup
const audioFileMap = new Set(audioFiles);

// 4. Iterate through the course data and update audio URLs
let updatedCount = 0;
courseData.forEach(day => {
    // Update listenURL
    if (day.listenURL) {
        const fileName = path.basename(day.listenURL);
        if (audioFileMap.has(fileName)) {
            const newUrl = `${R2_PUBLIC_URL}/${fileName}`;
            if (day.listenURL !== newUrl) {
                day.listenURL = newUrl;
                updatedCount++;
            }
        }
    }
    // Update readURL
    if (day.readURL) {
        const fileName = path.basename(day.readURL);
         if (fileName.endsWith('.mp3') && audioFileMap.has(fileName)) {
            const newUrl = `${R2_PUBLIC_URL}/${fileName}`;
             if (day.readURL !== newUrl) {
                day.readURL = newUrl;
                updatedCount++;
            }
        }
    }
});

console.log(`Updated ${updatedCount} audio URLs in the data file.`);

// 5. Write the updated data back to the JSON file
try {
    const updatedData = JSON.stringify(courseData, null, 2);
    fs.writeFileSync(DATA_FILE, updatedData, 'utf8');
    console.log('Successfully wrote updated data to course-data.json.');
} catch (error) {
    console.error(`Error writing updated data file: ${DATA_FILE}`, error);
    process.exit(1);
}

console.log('URL update process finished successfully!');
