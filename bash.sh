#!/bin/bash

export _USER=$USER

[ "$USER" != "root" ] && exec sudo -- "$0" "$@"

# Back Home

cd /home/$_USER

# Dotfiles

cd; curl -#L https://github.com/mathiasbynens/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE-MIT.txt}

# ls++

cpan Term::ExtendedColor
git clone git://github.com/trapd00r/ls--.git
cd ls--
perl Makefile.PL
make
make install

cp ls++.conf $HOME/.ls++.conf

# Back Home

cd /home/$_USER

# Update .alias file to include `alias ls=ls++'
cat <<EOT >> .alais
# Alias for ls++
alias ls=ls++
EOT
