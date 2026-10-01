final: prev: {
  htop = prev.htop.overrideAttrs (old: {
    # source: https://aur.archlinux.org/packages/htop-vim-git
    patches = (old.patches or []) ++ [ ./patches/htop-vim.patch ];
  });
}
