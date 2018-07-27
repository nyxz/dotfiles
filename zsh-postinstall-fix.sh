#/usr/bin/evn sh

echo "Adding imports to .zshrc"
cat ~/dotfiles/imports/rc >> ~/.zshrc

echo "Adding imports to .zprofile"
cat ~/dotfiles/imports/profile >> ~/.zprofile

echo "Adding imports to .profile"
cat ~/dotfiles/imports/profile >> ~/.profile

echo "Done."

