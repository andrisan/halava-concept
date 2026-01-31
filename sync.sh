#!/bin/bash
# sync.sh - Sync KMS (Obsidian vault) to flat markdown files
#
# Usage: ./sync.sh
#
# This script converts wikilinks [[target]] to standard markdown links [target](target.md)
# and copies all files from kms/ to flat/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KMS_DIR="$SCRIPT_DIR/kms"
FLAT_DIR="$SCRIPT_DIR/flat"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Syncing KMS → Flat...${NC}"

# Create flat directory if it doesn't exist
mkdir -p "$FLAT_DIR"

# Clean flat directory (except for any original files we want to keep)
rm -rf "$FLAT_DIR"/*

# Find all markdown files in kms (excluding .obsidian)
find "$KMS_DIR" -name "*.md" -not -path "*/.obsidian/*" | while read -r file; do
    # Get relative path from kms/
    rel_path="${file#$KMS_DIR/}"
    
    # Create target directory in flat/
    target_dir="$FLAT_DIR/$(dirname "$rel_path")"
    mkdir -p "$target_dir"
    
    target_file="$FLAT_DIR/$rel_path"
    
    # Convert wikilinks to standard markdown links
    # [[target]] → [target](target.md)
    # [[target#section]] → [target#section](target.md#section)
    # [[target|display]] → [display](target.md)
    sed -E '
        # Handle [[target|display]] - aliased links
        s/\[\[([^]|#]+)\|([^]]+)\]\]/[\2](\1.md)/g
        
        # Handle [[target#section]] - links with anchors
        s/\[\[([^]#|]+)#([^]|]+)\]\]/[\1#\2](\1.md#\2)/g
        
        # Handle [[target]] - simple links
        s/\[\[([^]|#]+)\]\]/[\1](\1.md)/g
    ' "$file" > "$target_file"
    
    echo -e "  ${GREEN}✓${NC} $rel_path"
done

# Count files
file_count=$(find "$FLAT_DIR" -name "*.md" | wc -l)
echo -e "${GREEN}✓ Synced $file_count files to flat/${NC}"
