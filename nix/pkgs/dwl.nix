{ pkgs }:
# Patched dwl package used by NixOS programs.dwl.package.
#
# 1. Drop patches into ../patches/dwl/*.patch and list them below.
# 2. When ready, set configH to ../config/dwl/config.h (copy from
#    config.h.example / upstream config.def.h first).
# 3. If a patch needs extra build inputs (e.g. bar → fcft, libdrm),
#    append them in overrideAttrs like the nixpkgs module example.
let
  patchesDir = ../patches/dwl;
  # Explicit list keeps rebuilds intentional. Add basenames as you vendor patches.
  patchFiles = [
    # "pertag.patch"
    # "vanitygaps.patch"
  ];
in
(pkgs.dwl.override {
  # null → upstream config.def.h. Switch to a local file once you port binds.
  configH = null;
  # configH = ../config/dwl/config.h;
}).overrideAttrs (oldAttrs: {
  pname = "dwl-patched";
  patches = (oldAttrs.patches or [ ]) ++ map (name: patchesDir + "/${name}") patchFiles;
  # buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ pkgs.fcft pkgs.libdrm ];
})