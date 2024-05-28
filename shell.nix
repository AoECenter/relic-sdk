let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in


pkgs.mkShell{
  packages = with pkgs; [
    clang
    gmp
    ocaml
    opam
    openssl
    ocamlPackages.ocamlformat
    ocamlPackages.ocaml-lsp
    pkg-config
    wireshark
    zlib
  ];
  shellHook = ''
    export C_INCLUDE_PATH=${pkgs.zlib.dev}/include:$C_INCLUDE_PATH
    export LIBRARY_PATH=${pkgs.zlib}/lib:$LIBRARY_PATH
    export OPAM_SWITCH_PREFIX=$HOME/.opam/5.2.0
    eval $(opam env)
  '';
}
