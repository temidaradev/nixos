# nix-config — Docs

Personal NixOS + nix-darwin config. Hosts under `hosts/<host>/`, OS modules under `nixos/` and `darwin/`.

## Layout

```
.
├── flake.nix
├── hosts/
│   ├── nixos/{machine,hardware,packages}.nix     # x86_64-linux
│   └── darwin/{machine,packages}.nix              # aarch64-darwin
├── nixos/      # NixOS-only modules
└── darwin/     # Darwin-only modules (system, users, homebrew)
```

Host-specific values (`hostName`, `stateVersion`, package overrides) live in `hosts/<host>/machine.nix`. Cross-host modules go in `nixos/` or `darwin/`.

## Rebuild

### Darwin

```
nh darwin switch .            # from repo dir
# or explicit:
nh darwin switch /Users/lidldev/Projects/nix-config

# raw fallback (when nh broken):
sudo darwin-rebuild switch --flake .#temidaradev-darwin

# first-time bootstrap (before darwin-rebuild exists):
nix run nix-darwin/master#darwin-rebuild -- switch --flake .#temidaradev-darwin
```

`NH_FLAKE` env var auto-set after first switch. Restart shell or `source /etc/zshrc` to pick up — then bare `nh darwin switch` works.

### NixOS

```
nh os switch .
# or:
sudo nixos-rebuild switch --flake .#temidaradev
```

## Adding a new host

```
mkdir hosts/<name>
# create hosts/<name>/machine.nix and packages.nix
```

Then in `flake.nix` add under `nixosConfigurations` or `darwinConfigurations`:

```nix
darwinConfigurations.<name> = nix-darwin.lib.darwinSystem {
  modules = [ ./hosts/<name>/machine.nix { nixpkgs.pkgs = mkPkgs darwinSystem; } ];
  specialArgs = { system = darwinSystem; inputs = { }; };
};
```

## Adding packages

### Pure nix (preferred)

`hosts/darwin/packages.nix` (or `hosts/nixos/packages.nix`):

```nix
system = [
  fastfetch
  # ...
];
```

Find package names: `nix search nixpkgs <name>` or [search.nixos.org/packages](https://search.nixos.org/packages).

### Brew (when nix can't / nixpkgs broken on darwin)

`darwin/homebrew/default.nix`:

```nix
brews = [ "cocoapods" ];        # formulae
casks = [ "rectangle" ];         # GUI apps
masApps = { "Xcode" = 497799835; };   # App Store apps
taps = [ "nikitabobko/tap" ];    # custom taps
```

Decision rules:
- CLI tool, well-maintained on darwin → nix
- GUI app (Rectangle, Karabiner, etc.) → cask
- Mac App Store app → masApps (find ID via `mas search <name>`)
- Custom tap formula → brews (include `tap/name` path) + add tap to `taps`
- nixpkgs marks darwin broken → brew

## Removing brew packages already migrated to nix

`onActivation.cleanup = "none"` means nix-darwin won't touch existing brew installs. Clean up manually.

### 1. Verify nix replacements work

```
which git           # → /run/current-system/sw/bin/git (not /opt/homebrew/bin/git)
git --version
```

If brew still wins PATH: uninstall brew copy (next step).

### 2. List safe-to-remove brew formulae

Anything you moved to nix is duplicated. Check dependencies first:

```
brew uses --installed <name>     # what depends on it
```

Empty output → safe to remove. Non-empty → another brew formula needs it; either remove dependents first, or leave alone.

### 3. Bulk check from a list

```
cat > /tmp/migrated.txt <<EOF
git
fzf
bat
btop
fastfetch
# ... everything you moved to hosts/darwin/packages.nix
EOF

while read p; do
  uses=$(brew uses --installed "$p" 2>/dev/null)
  if [ -n "$uses" ]; then
    echo "KEEP $p ← $uses"
  else
    echo "SAFE $p"
  fi
done < /tmp/migrated.txt
```

### 4. Uninstall

```
brew uninstall git fzf bat btop fastfetch ...
```

Plain `brew uninstall` refuses if other brew formulae depend. Don't use `--force` blindly.

### 5. Clean orphans + caches

```
brew autoremove          # drop deps no longer needed
brew cleanup -s          # nuke old versions + cache
rm -rf $(brew --cache)   # full cache wipe
```

### 6. Flip nix-darwin cleanup mode (optional)

Once everything declared in nix config or accepted-in-brew:

`darwin/homebrew/default.nix`:
```nix
cleanup = "uninstall";   # remove undeclared brew formulae (keeps app data)
# or:
cleanup = "zap";         # remove undeclared + their data/configs
```

Rebuild → anything not in `brews`/`casks`/`masApps` gets uninstalled by brew bundle.

⚠️ `zap` is irreversible for app data. Inventory before flipping.

## Garbage collect nix store

```
nh clean all -k 3        # keep last 3 generations, delete older
# or:
nix-collect-garbage -d   # nuke all old gens system-wide
sudo nix-collect-garbage -d   # also system profile
```

Check store size:
```
du -sh /nix/store
```

Typical first GC: 5–20 GB freed.

## Updating

### Flake inputs

```
nix flake update                    # all inputs
nix flake update nixpkgs            # one input
```

Then rebuild.

### Brew

```
brew update && brew upgrade && brew upgrade --cask
```

nix-darwin runs `brew update` + `brew upgrade` on each switch (`autoUpdate = true`, `upgrade = true`). If brew bundle starts erroring with "Failed to fetch" on outdated formulae, run the manual command above to catch up.

## Troubleshooting

### `nh darwin switch` says "flake does not provide attribute ... darwinConfigurations.<host>"

`NH_FLAKE` not exported in current shell. Pass path explicit:
```
nh darwin switch .
```

### "'X' has been removed because it was unmaintained" / "X is broken"

Package retired or marked broken on darwin in nixpkgs. Either:
- Drop from `hosts/darwin/packages.nix`
- Find replacement: `nix search nixpkgs <similar-name>` (e.g. `neofetch` → `fastfetch`)
- Move to `darwin/homebrew/default.nix` `brews`

### "undefined variable 'X'"

Attribute name wrong. Common renames on darwin:
- `gpatch` → `patch` (nixpkgs ships GNU patch)
- `gnu-sed` → `gnused`
- `telnet` → `inetutils` (provides telnet, ftp, ping, hostname)
- `openjdk@17` → `openjdk17`
- `python@3.12` → `python312`
- `node@22` → `nodejs_22`

Check: `nix eval --raw nixpkgs#<name>.meta.description`.

### `brew bundle` fails "Failed to fetch" on outdated formulae

Brew can't upgrade in batch (rate limit or version mismatch). Manual:
```
brew update
brew upgrade
brew upgrade --cask
```
Then re-run `nh darwin switch .`.

### macOS shadows nix in PATH

`/opt/homebrew/bin` ranks before `/run/current-system/sw/bin` by default. Either:
- Uninstall the brew duplicate of the binary
- Reorder in `~/.zshrc`:
  ```
  export PATH="/run/current-system/sw/bin:/run/current-system/sw/sbin:$PATH"
  ```

Check resolution: `which -a <cmd>`.

### Cask name not in homebrew-cask

Cask renamed or moved to custom tap. Search:
```
brew search <name>
```
Use full tap path if non-core: `vendor/tap/cask-name`.

### App Store install fails

Sign into App Store app once, then `mas account` should show your Apple ID. Without active session `mas install` fails silently → nix-darwin reports brew bundle error.

## Quick reference

| Task | Command |
|------|---------|
| Rebuild darwin | `nh darwin switch .` |
| Rebuild NixOS | `nh os switch .` |
| Update flake inputs | `nix flake update` |
| Search nixpkgs | `nix search nixpkgs <name>` |
| Search brew | `brew search <name>` |
| Find MAS app ID | `mas search "<app name>"` |
| GC nix store | `nh clean all -k 3` |
| Brew cleanup | `brew autoremove && brew cleanup -s` |
| Show disk | `df -h / && du -sh /nix/store /opt/homebrew` |
| Rollback darwin | `darwin-rebuild --rollback` |
| List generations | `darwin-rebuild --list-generations` |

## Hosts

| Host | OS | System | Notes |
|------|-----|--------|-------|
| temidaradev | NixOS | x86_64-linux | Hyprland desktop, gaming, dev |
| temidaradev-darwin | macOS | aarch64-darwin | Apple Silicon, nix + brew hybrid |
