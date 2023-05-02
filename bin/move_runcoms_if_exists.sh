#!/bin/bash

echo $#
# Check if the correct number of arguments is provided
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 source_directory"
  exit 1
fi

source_directory="$1"
DOTFILES_DIR="$2"

# Check if source and target directories exist
if [[ ! -d "$source_directory" ]]; then
  echo "Source directory does not exist: $source_directory"
  exit 1
fi

# Create a directory for backups
timestamp=$(date +%Y%m%d_%H%M%S)
target_directory=~/.dotfiles_backup/${timestamp}
mkdir -p "${target_directory}"

shopt -s dotglob

echo "Source: ./$source_directory"
# Iterate through files in the source directory
for file in "./$source_directory"/*; do
  if  [ -f "${file}" ]; then
    echo "Checking ~/$(basename "$file")"
    # Check if the file exists in the target directory
    if [[ -f ~/$(basename "$file") ]]; then
      # Move the file from the source directory to the target directory
      mv ~/$(basename "$file") $target_directory
      echo "Backed up: $(basename "$file")" to $target_directory
    fi
  fi
  stow -t $HOME $source_directory
done
