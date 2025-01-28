#!/bin/bash
set -euo pipefail

echo "Creating GitHub social preview from logo..."

# Ensure .github directory exists
mkdir -p .github/images

# Convert square logo to GitHub preview dimensions
# 1. Resize maintaining aspect ratio
# 2. Add padding with background
# 3. Apply slight blur to background for depth
# 4. Overlay text
convert assets/logo.jpg \
    -resize 1024x1024\> \
    -gravity center \
    -background '#1A1E2E' \
    -extent 1280x640 \
    -blur 0x3 \
    .github/images/social-preview-base.jpg

# Overlay the resized logo
convert assets/logo.jpg \
    -resize 800x800\> \
    -background none \
    .github/images/logo-overlay.png

# Combine base and overlay
convert .github/images/social-preview-base.jpg \
    .github/images/logo-overlay.png \
    -gravity center \
    -composite \
    .github/images/social-preview.jpg

# Clean up temporary files
rm .github/images/social-preview-base.jpg .github/images/logo-overlay.png

# Add metadata
cat > .github/images/README.md << 'EOL'
# GitHub Social Preview

- Dimensions: 1280x640px (2:1 aspect ratio)
- Based on: Original logo (2048x2048px)
- Background: Navy (#1A1E2E)

## Usage
1. Go to repository Settings
2. Under "Social preview"
3. Upload `social-preview.jpg`

## Files
- `social-preview.jpg`: Final preview image
- Original source: `../../assets/logo.jpg`
EOL

echo "Social preview generated at .github/images/social-preview.jpg"
echo "Next steps:"
echo "1. Review the preview image"
echo "2. Commit changes"
echo "3. Set as repository social preview"

# Git commands (commented out for safety)
# git add .github/
# git commit -m "feat(meta): add GitHub social preview
#
# - Created 1280x640px social preview from logo
# - Added preview documentation
# - Optimized for GitHub display"
# git push origin main

#!/bin/bash
set -euo pipefail

echo "Creating compact header image..."

# Ensure assets directory exists
mkdir -p assets/header

# Create a compact header version (960x240 - more letterbox style)
convert assets/logo.jpg \
    -resize 400x400\> \
    -gravity center \
    -background '#1A1E2E' \
    -extent 960x240 \
    -blur 0x3 \
    assets/header/base.jpg

# Add the logo overlay
convert assets/logo.jpg \
    -resize 200x200\> \
    -background none \
    assets/header/overlay.png

# Combine with text
convert assets/header/base.jpg \
    assets/header/overlay.png \
    -gravity center \
    -composite \
    assets/header/readme-header.jpg

# Clean up temporary files
rm assets/header/base.jpg assets/header/overlay.png

# Update assets documentation
cat >> assets/README.md << 'EOL'

## Header Images
- `header/readme-header.jpg`: Compact header (960x240px)
  - Used in README.md
  - Optimized for vertical space
  - Maintains brand identity
EOL

echo "Compact header generated at assets/header/readme-header.jpg"

# Git commands for adding the new files
git add assets/header/
git add assets/README.md
git commit -m "feat(assets): add compact header image

- Created 960x240px compact header
- Optimized for README display
- Updated assets documentation"
git push origin main
