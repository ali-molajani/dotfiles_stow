# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

test -s ~/.alias && . ~/.alias || true
. "$HOME/.cargo/env"
# starship
eval "$(starship init bash)"
# nvim alias
alias vi='nvim'
alias lg='lazygit'
alias condaup='source ~/miniconda3/bin/activate'
alias la='ls -latrh'
# fzf complitation
source <(fzf --bash)
# set the manpager to nvim
export MANPAGER="nvim +Man!"
# if you are using password for ssh use below commands to prevent password for cloning
# if [ -z "$SSH_AUTH_SOCK" ] ; then
#    eval "$(ssh-agent -s)"
#    ssh-add ~/.ssh/id_rsa
# fi
