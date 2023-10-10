{ lib, stdenv, mdbook, documentation-src }:

stdenv.mkDerivation {
  pname = "projekte-afbb";
  version = "0.1.0";

  src = documentation-src;

  nativeBuildInputs = [ mdbook ];

  buildPhase = ''
    ${mdbook}/bin/mdbook build
  '';

  installPhase = ''
    mkdir -p $out/bin/
    cp -r book/* $out/bin/
  '';

  meta = with lib; {
    description = "Dokumentation für die Afbb-Projekte im 3. Lehrjahr";
    homepage = "https://github.com/neonwhiskers/projekte-afbb";
  };
}
