#!/bin/bash -eux

# search for package availability in: https://formulae.brew.sh/formula/


#BREW='/home/linuxbrew/.linuxbrew/bin/brew shellenv ; brew'

function install_package {
    apt-get install -y --no-install-recommends "$@"
    #echo "$@"
}

function install_package_using_brew {
    for item in "$@"; do
        # NOTE: for some strange reason $@ was being truncated at the first word, not even an echo $@ would work within the runuser scope
        runuser -l $(id -nu  1000) -c "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\" && brew install $item"
    done
}

function install_tmux {
    install_package_using_brew tmux
    # this ensures the latest version of the plugin
    runuser -l $(id -nu 1000) -c 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'
}


# nnn, yazi, and their (optional) dependencies
install_package ffmpegthumbnailer unar jq poppler-utils
install_package archivemount trash-cli
install_package_using_brew fd ripgrep fzf zoxide
install_package_using_brew nnn yazi

# neovim and dependencies for its plugins
install_package_using_brew neovim
install_package_using_brew node fish lazygit luarocks virtualenv

# other packages
install_tmux
install_package_using_brew git-lfs # seems like there is a bug impacting soft-serve which was only fixed in v3.4.1, see https://github.com/charmbracelet/soft-serve/issues/385

