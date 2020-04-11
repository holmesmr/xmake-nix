#!/usr/bin/env bash

ver=$1
ver_path="./version/${ver}"
data_path="${ver_path}/git-inputs.json"

mkdir -p "${ver_path}"
echo "Setting Git information for xmake ${ver}"
nix-prefetch-git --quiet --fetch-submodules --no-deepClone https://github.com/xmake-io/xmake refs/tags/v${ver} > "${data_path}" || (echo "Prefetching git repo failed" && exit 1)
echo "Generating Nix expression"
tee "${ver_path}/build.nix" <<EOF > /dev/null
with import <nixpkgs> {};

callPackage ../../build-xmake.nix {
  version = "${ver}";
  gitInputs = lib.importJSON ./git-inputs.json;
}
EOF
