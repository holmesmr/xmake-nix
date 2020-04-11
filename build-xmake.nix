{ stdenv
, fetchgit
, version
, gitInputs
, gnumake
, gcc
, coreutils
, readline
, git
}:
stdenv.mkDerivation {
  inherit version;
  
  pname = "xmake";
  
  patches = [ ./make-deterministic.patch ];
  
  nativeBuildInputs = [
    gnumake
    gcc
    coreutils
    readline
    git
  ];
  
  src = fetchgit {
    inherit (gitInputs) url rev sha256 fetchSubmodules;
  };

  buildPhase = ''
    make build
  '';

  installPhase = ''
    make install PREFIX=$out
  '';
}
