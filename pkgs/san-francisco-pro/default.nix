{
  lib,
  stdenvNoCC,
  source,
  ...
}:
stdenvNoCC.mkDerivation {
  inherit (source) pname src version;

  buildPhase = ''
    runHook preBuild

    # Create the destination directory
    mkdir -p $out/share/fonts/San-Francisco-Pro

    # Copy the .ttf files to the destination directory
    cp -r $src/*.ttf $out/share/fonts/San-Francisco-Pro

    runHook postBuild
  '';

  meta = with lib; {
    description = "San Francisco Pro Fonts";
    homepage = "https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts";
    license = licenses.unfree;
    platforms = platforms.all;
  };
}
