#!/bin/bash

# === Configuration ===
# The name of your R2 bucket
R2_BUCKET_NAME="emotion-app-audio"
# The folder containing your React project's source code
PROJECT_SOURCE_DIR="./frontend"
# The local directory where your audio files are stored
AUDIO_SOURCE_DIR="./情绪练习室-柔和粉/audio"
# The directory where `npm run build` outputs the final website files
BUILD_DIR="./frontend/dist"
# Your GitHub username
GITHUB_USERNAME="Echo11120920"
# Your GitHub repository name
GITHUB_REPO_NAME="emotion-ebp-app"
# Commit message for the deployment
COMMIT_MESSAGE="Deploy to GitHub Pages $(date +'%Y-%m-%d %H:%M:%S')"
# === End Configuration ===

# Function to print messages
function log {
  echo "✅ [Deploy Script] $1"
}

# --- Start Script ---

# 1. Navigate to the script's own directory to ensure relative paths work
cd "$(dirname "$0")"
log "Working directory: $(pwd)"


# 2. Upload audio files to Cloudflare R2
log "Uploading audio files from '$AUDIO_SOURCE_DIR'... (This may take a while)"
# Use a loop for maximum compatibility, as proven in our debugging
for f in "$AUDIO_SOURCE_DIR"/*.mp3; do
  if [ -f "$f" ]; then
    FILENAME=$(basename "$f")
    log "Uploading $FILENAME..."
    # Check if the file already exists to avoid re-uploading
    if ! wrangler r2 object get "$R2_BUCKET_NAME/$FILENAME" >/dev/null 2>&1; then
      wrangler r2 object put "$R2_BUCKET_NAME/$FILENAME" --file "$f"
      if [ $? -ne 0 ]; then
        echo "❌ Error: Failed to upload $FILENAME. Aborting."
        exit 1
      fi
    else
      log "$FILENAME already exists in R2, skipping."
    fi
  fi
done
log "All audio files are synced successfully."


# 3. Update the course data with new R2 URLs
log "Running script to update audio URLs in course-data.json..."
node ./scripts/update-urls.js
if [ $? -ne 0 ]; then
  echo "❌ Error: Failed to update URLs in JSON file. Aborting."
  exit 1
fi
log "JSON file updated successfully."


# 4. Build the React application
log "Building the React application from '$PROJECT_SOURCE_DIR'..."
# Save current dir and cd into project source
START_DIR=$(pwd)
cd "$PROJECT_SOURCE_DIR" || exit
npm install
npm run build
if [ $? -ne 0 ]; then
  echo "❌ Error: React build failed. Aborting."
  cd "$START_DIR"
  exit 1
fi
log "React application built successfully."
cd "$START_DIR" # Go back to the script's root directory


# 5. Deploy to GitHub Pages
log "Preparing to deploy to GitHub Pages..."

# Navigate to the build output directory
cd "$BUILD_DIR" || exit

# Initialize a new git repository, commit and push to the gh-pages branch
git init
git add -A
git commit -m "$COMMIT_MESSAGE"
git push -f "https://$GITHUB_USERNAME@github.com/$GITHUB_USERNAME/$GITHUB_REPO_NAME.git" main:gh-pages

if [ $? -ne 0 ]; then
  echo "❌ Error: Failed to push to GitHub Pages. Aborting."
  exit 1
fi

log "🚀 Deployment successful!"
log "Your site should be live at https://$GITHUB_USERNAME.github.io/$GITHUB_REPO_NAME/ shortly."
log "Cleaning up..."
rm -rf .git

# --- End Script ---
