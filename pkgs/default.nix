{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: let
    sources = (import ./_sources/generated.nix) {
      inherit (pkgs) dockerTools fetchurl fetchgit fetchFromGitHub;
    };
  in {
    packages = {
      multicolor-sddm-theme = pkgs.callPackage ./multicolor-sddm-theme {
        inherit sources;
        source = sources.multicolor-sddm-theme;
      };

      san-francisco-pro = pkgs.callPackage ./san-francisco-pro {
        inherit sources;
        source = sources.san-francisco-pro;
      };

      iosevka-q = pkgs.callPackage ./iosevka-q {};

      spotify = pkgs.callPackage ./spotify {};

      TLauncher = pkgs.callPackage ./TLauncher {};

      vesktop = pkgs.callPackage ./vesktop {};

      webcord-vencord = pkgs.callPackage ./webcord-vencord {};
    };
  };
}
