# Check for cURL

if ! command -v curl &> /dev/null
then
  echo "cURL not installed"
  exit
fi

echo "attempting to install vimplug..."

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Check result of vimplug install
if [ $? -ne 0 ]; then
  echo "install of vimplug failed, aborting."
  exit
fi

# Check for existing vimrc
if test -f "~/.vimrc"; then
    echo "found existing .vimrc, saving as .vimrc-old"
    mv ~/.vimrc ~/.vimrc-old
fi

# Copy this vimrc into place
cp .vimrc ~/.vimrc

# Run PlugInstall in vim
echo "Preparing to install vim plugins, you'll need to press enter\
 to skip warnings, these will only display once."
vim +PlugInstall +qall

if [ $? -ne 0 ]; then
  echo "vim quit with an unexpected exit code, please verify\
  plugins were installed correctly."
  exit
fi
echo "OK!"