url 'ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2';

sub install {
    configure(qw/--disable-gui --without-x --disable-xim --enable-multibyte/);
    make();
    make('install');
}

