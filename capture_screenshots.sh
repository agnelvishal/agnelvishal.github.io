#!/bin/bash

# Array of project names and URLs
declare -A projects
projects=(
    ["askpondy"]="https://askpondy.com"
    ["sampriti"]="https://sampritibotanicals.com"
    ["blooming"]="https://bloomingreenfestival.com"
    ["nexqloud"]="https://www.nexqloud.io"
    ["truliv"]="https://www.truliv.in"
    ["agasthiyar"]="https://agasthiyarherbalproducts.com"
    ["ai-song"]="https://app.gptindia.pro"
    ["nirupam"]="https://nirupam.org"
    ["bhu-ceramics"]="https://bhuceramics.com"
    ["maroma"]="https://maroma.com"
    ["boldstree"]="https://boldstree.com"
)

# Directory for screenshots
OUTPUT_DIR="assets/images/projects"
mkdir -p "$OUTPUT_DIR"

# Loop through projects and capture screenshots
for name in "${!projects[@]}"; do
    url="${projects[$name]}"
    output_file="$OUTPUT_DIR/$name.png"
    
    echo "Capturing $name from $url..."
    
    # Use google-chrome in headless mode
    # Set window size to a typical desktop resolution
    # Use a virtual time budget to allow for some loading (though it might still be fast)
    # The --screenshot argument specifies the output file (requires newer Chrome/Chromium)
    # If standard --screenshot doesn't support path, we might need to move it. 
    # Usually --screenshot saves to 'screenshot.png' in CWD if no file specified, 
    # but let's try specifying it or moving it.
    # Actually, --screenshot doesn't take an argument in some versions, it just saves 'screenshot.png'.
    # Let's try to capture to default execution and move.
    
    timeout 30s google-chrome --headless --disable-gpu --window-size=1280,800 --hide-scrollbars --screenshot="$output_file" "$url"
    
    if [ $? -eq 0 ]; then
        echo "Successfully captured $name"
    else
        echo "Failed to capture $name"
        # Try without specifying output file to --screenshot if the version is old?
        # But 'google-chrome --version' was 120+, so it should support it.
        # Just in case, if it fails, we can try a fallback or just log it.
    fi
done

echo "Screenshot capture complete."
