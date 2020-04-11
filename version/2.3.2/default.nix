with import <nixpkgs> {};

callPackage ../../build-xmake.nix {
  version = "2.3.2";
  gitInputs = lib.importJSON ./git-inputs.json;
}
