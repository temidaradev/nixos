# nix-config

Nix config for two machines:

- `temidaradev`: NixOS desktop (x86_64-linux)
- `temidaradev-darwin`: Apple Silicon Mac (aarch64-darwin), via [nix-darwin](https://github.com/nix-darwin/nix-darwin)

## Rebuild

```bash
nh darwin switch .   # macOS
nh os switch .       # NixOS
```

Edit `hosts/<host>/packages.nix`, then rebuild. Mac GUI apps and brews go in `darwin/homebrew/default.nix`.

Homebrew uses `cleanup = "uninstall"`: anything not in that file gets removed on rebuild. Don't `brew install` by hand, add it to the file.
