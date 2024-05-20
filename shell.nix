let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in


pkgs.mkShell{
  packages = with pkgs; [
    gmp
    ocaml
    opam
    openssl
    ocamlPackages.ocamlformat
    ocamlPackages.ocaml-lsp
    pkg-config
    zlib
  ];
  shellHook = ''
    export C_INCLUDE_PATH=${pkgs.zlib.dev}/include:$C_INCLUDE_PATH
    export LIBRARY_PATH=${pkgs.zlib}/lib:$LIBRARY_PATH
  '';
}
