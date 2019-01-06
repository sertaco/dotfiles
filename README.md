# .dotfiles
.dotfiles is personal and customized for one's use cases. This one is for myself and you are free to take anything you 
like at your own risk. 

I would advice starting small and building your .dotfiles in time.  

This .dotfiles is intended for both macos and centos as these two are currently in my daily work flow. 

## Package Overview
- Homebrew
- Zsh
- Oh-My-Zsh
- Powerlevel9k OMZ theme
- Stow
- git
- vim
- Go
- direnv
- mdp

## Install
    git clone https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/dotfiles ~/.dotfiles

Use the [Makefile](./Makefile) to install everything [listed above](#package-overview), and symlink [runcom](./runcom) and [config](./config) (using [stow](https://www.gnu.org/software/stow/)):

    cd ~/.dotfiles
    make

## Post-install
For leveraging direnv with virtualenv of Python, add a .envrc file with following content to the parent directory
of each of the Python workspaces:

    source venv/bin/activate

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io) and [Lars Kappert](https://github.com/webpro/dotfiles).