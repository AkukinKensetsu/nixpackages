{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: let
    sources = (import ./_sources/generated.nix) {
      inherit (pkgs) dockerTools fetchurl fetchgit fetchFromGitHub;
    };
  in {
    packages = {
      bcachefs-kernel = pkgs.callPackage ./bcachefs-kernel {
        # Pinned on the last version which Kent's commits can be cleany rebased up.
        kernel = pkgs.linux_6_5;
        kernelPatches = pkgs.linux_6_5.kernelPatches;
      };

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

      webcord-vencord = pkgs.callPackage ./webcord-vencord {};
    };
  };
}
