{
  stdenv,
  lib,
  source,
  ...
}:
stdenv.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    mkdir -p $out/share/sddm/themes/multicolor-sddm-theme
    mv * $out/share/sddm/themes/multicolor-sddm-theme
  '';

  meta = with lib; {
    description = "DT's SDDM Theme";
    homepage = "https://gitlab.com/dwt1/multicolor-sddm-theme";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ludovicopiero];
    platforms = platforms.linux;
  };
}
