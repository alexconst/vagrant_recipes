
function install_package {
    apt-get install -y --no-install-recommends "$@"
    #echo "$@"
}

function install_package_with_recommends {
    apt-get install -y "$@"
    #echo "$@"
}

function install_package_using_brew {
    for item in "$@"; do
        # NOTE: for some strange reason $@ was being truncated at the first word, not even an echo $@ would work within the runuser scope
        runuser -l $(id -nu  1000) -c "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\" && brew install $item"
    done
}

