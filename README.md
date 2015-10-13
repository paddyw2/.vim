# VIM settings

Allows settings to be accessible anywhere for a quick VIM setup.

Simply clone into home directory.

Once cloned and a <code>.vim</code> directory has been created, run the following command to link the <code>.vimrc</code> file to the home directory:

<code>ln -s ~/.vim/.vimrc ~/.vimrc</code>

If running Linux, the number of supported colours may need to be updated. To do this, run:

<code>sudo apt-get install ncurses-term</code>

and then add this line to the <code>~./bashrc</code> file:

<code>export TERM=xterm-256color</code>
