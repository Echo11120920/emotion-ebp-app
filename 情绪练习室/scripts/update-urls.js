
const fs = require('fs');
const path = require('path');

// --- Configuration ---
const R2_PUBLIC_URL = 'https://pub-fe7f2c70ab5a4168a971de6d441975a6.r2.dev';
const PROJECT_ROOT = path.join(__dirname, '..'); 
const AUDIO_DIR = path.join(PROJECT_ROOT, '情绪练习室-柔和粉', 'audio');
const DATA_FILE = path.join(PROJECT_ROOT, 'frontend', 'src', 'data', 'course-data.json');
// --- End Configuration ---

console.log('Starting URL update process...');
console.log(`Audio directory: ${AUDIO_DIR}`);
console.log(`Data file: ${DATA_FILE}`);

let audioFiles;
try {
    audioFiles = fs.readdirSync(AUDIO_DIR).filter(f => f.endsWith('.mp3'));
    console.log(`Found ${audioFiles.length} audio files.`);
} catch (error) {
    console.error(`Error reading audio directory: ${AUDIO_DIR}`, error);
    process.exit(1);
}

let courseData;
try {
    const rawData = fs.readFileSync(DATA_FILE, 'utf8');
    courseData = JSON.parse(rawData);
    console.log('Successfully read and parsed course-data.json.');
} catch (error) {
    console.error(`Error reading or parsing data file: ${DATA_FILE}`, error);
    process.exit(1);
}

const audioFileMap = new Set(audioFiles);

let updatedCount = 0;
// Correctly loop into the nested exercises array
courseData.days.forEach(day => {
  if (day.exercises && Array.isArray(day.exercises)) {
    day.exercises.forEach(exercise => {
      // Check for audioUrl and update it
      if (exercise.audioUrl) {
        const fileName = path.basename(exercise.audioUrl);
        // Check if this audio file is one we have locally
        if (audioFileMap.has(fileName)) {
          const newUrl = `${R2_PUBLIC_URL}/${fileName}`;
          if (exercise.audioUrl !== newUrl) {
            exercise.audioUrl = newUrl;
            updatedCount++;
            console.log(`Updated ${fileName} to ${newUrl}`);
          }
        }
      }
    });
  }
});

console.log(`Total URLs updated: ${updatedCount}`);

try {
    const updatedData = JSON.stringify(courseData, null, 2);
    fs.writeFileSync(DATA_FILE, updatedData, 'utf8');
    console.log('Successfully wrote updated data to course-data.json.');
} catch (error) {
    console.error(`Error writing updated data file: ${DATA_FILE}`, error);
    process.exit(1);
}

console.log('URL update process finished successfully!');
