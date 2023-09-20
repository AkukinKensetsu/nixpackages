{pkgs ? import <nixpkgs> {}}:
with pkgs;
  mkShell {
    buildInputs = [
      alejandra # Formatter
      statix
      deadnix
    ];
  }
