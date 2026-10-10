# dwl patches

Drop upstream patches from
[dwl-patches](https://codeberg.org/dwl/dwl-patches) here as `.patch` files, then
list them in [`../pkgs/dwl.nix`](../pkgs/dwl.nix).

Patch order matters. Rebuild after every change:

```bash
sudo nixos-rebuild switch --flake .#example-laptop
```

Starter ideas that map well from a patched dwm:

| Goal | Look for in dwl-patches |
|------|-------------------------|
| Status bar | `bar`, or run external `dwlb` / `someblocks` |
| Per-tag layouts | `pertag` |
| Gaps | `vanitygaps` |
| Better multi-monitor | `monfig`, `focusonnetactive` |

Pin patch files to the **same dwl version** as nixpkgs (or override `src` in
`dwl.nix` if you track upstream `main`).
