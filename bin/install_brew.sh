#!/bin/bash

if ! command -v brew &> /dev/null
then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile
else
    # Homebrew is already installed
    echo "brew is already installed on this system."
fi