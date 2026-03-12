#!/bin/bash
# Install Impeccable skills for Cursor

SOURCE_DIR="/tmp/impeccable/source/skills"
TARGET_DIR="/Users/zhangxiaoqian/.openclaw/workspace/.cursor/skills"

# Ensure target directory exists
mkdir -p "$TARGET_DIR"

# Function to convert a skill
download_skill() {
    local skill_name=$1
    local skill_dir="$SOURCE_DIR/$skill_name"
    local target_skill_dir="$TARGET_DIR/$skill_name"
    
    mkdir -p "$target_skill_dir"
    
    # Read the original SKILL.md and convert frontmatter
    local skill_file="$skill_dir/SKILL.md"
    if [ -f "$skill_file" ]; then
        # Extract frontmatter values
        local name=$(grep "^name:" "$skill_file" | head -1 | cut -d':' -f2- | xargs)
        local description=$(grep "^description:" "$skill_file" | head -1 | cut -d':' -f2- | xargs)
        local license=$(grep "^license:" "$skill_file" | head -1 | cut -d':' -f2- | xargs)
        
        # Create Cursor format frontmatter
        echo "---" > "$target_skill_dir/SKILL.md"
        echo "name: ${name:-$skill_name}" >> "$target_skill_dir/SKILL.md"
        echo "description: ${description:-\"Design skill for $skill_name\"}" >> "$target_skill_dir/SKILL.md"
        if [ -n "$license" ]; then
            echo "license: $license" >> "$target_skill_dir/SKILL.md"
        fi
        echo "---" >> "$target_skill_dir/SKILL.md"
        echo "" >> "$target_skill_dir/SKILL.md"
        
        # Extract body (after frontmatter)
        awk 'BEGIN{found=0} /^---/{if(found==0){found=1; next} else {found=2; next}} found==2{print}' "$skill_file" >> "$target_skill_dir/SKILL.md"
        
        echo "✓ Converted: $skill_name"
    fi
    
    # Copy reference files if they exist (for frontend-design)
    if [ -d "$skill_dir/reference" ]; then
        mkdir -p "$target_skill_dir/reference"
        cp "$skill_dir/reference/"*.md "$target_skill_dir/reference/" 2>/dev/null
        echo "  ↳ Copied reference files"
    fi
}

# Convert all skills
echo "Installing Impeccable skills for Cursor..."
echo ""

for skill_dir in "$SOURCE_DIR"/*; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        download_skill "$skill_name"
    fi
done

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps for Cursor:"
echo "1. Switch to Cursor Nightly channel (Settings → Beta)"
echo "2. Enable Agent Skills (Settings → Rules)"
echo "3. Copy .cursor/skills/ to your project root"
echo ""
