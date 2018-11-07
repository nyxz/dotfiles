#/usr/bin/evn sh

mkdir "${HOME}/.npm-packages"

echo "Create structure to install node packages globally without sudo"
ln -s "${HOME}/dotfiles/npmrc" "${HOME}/.npmrc"

echo "Adding NodeJS imports to .zshrc"
cat "${HOME}/dotfiles/imports/rc.nodejs" >> "${HOME}/.zshrc"

