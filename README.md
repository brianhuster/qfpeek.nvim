# qfpeek.nvim

A minimal Neovim plugin that provides quick preview functionality for quickfix and
location list entries in a floating window.

![demo](https://private-user-images.githubusercontent.com/111893501/464324451-f466be5e-cb39-4063-971c-72aedfa794bd.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTIxMzUwOTksIm5iZiI6MTc1MjEzNDc5OSwicGF0aCI6Ii8xMTE4OTM1MDEvNDY0MzI0NDUxLWY0NjZiZTVlLWNiMzktNDA2My05NzFjLTcyYWVkZmE3OTRiZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNzEwJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDcxMFQwODA2MzlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00MzEzNDU5MmEwNTVlNzFkZmY2M2IxOTMzMGMwYTFjMjM0OTBiNzYxZjk4OTVhZjFlMTAxM2JiNjZiYzE4YmNhJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.CFulA2igdUmMiOIhqjOTD-I43Nugo6MtWJWWvZdl3aE)

## Installation

Requires Nvim 0.11 or later (lower versions may work but are not tested).

This plugin can be installed using any package manager that supports Git repo, such as `lazy.nvim`, `vim-plug`, etc.
Or you can also use built-in `package` feature of Neovim
```bash
git clone https://github.com/brianhuster/qfpeek.nvim ~/.config/nvim/pack/plugins/start/qfpeek.nvim
```

**NOTE**: This plugin doesn't require lazy-loading, because it is lazy-loaded by default.

See [:h qfpeek](doc/qfpeek.txt) for more information on usage and configuration.

## See also

- [Similar plugins](https://github.com/brianhuster/qfpeek.nvim/wiki/Similar-plugins)
