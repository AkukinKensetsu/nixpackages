{
  webcord,
  substituteAll,
  lib,
  vencord-web-extension,
  electron_27,
}:
(webcord.overrideAttrs (old: {
  pname = "webcord-vencord";

  patches =
    (old.patches or [])
    ++ [
      (substituteAll {
        src = ./add-extension.patch;
        vencord = vencord-web-extension;
      })
    ];

  meta = with lib;
    old.meta
    // {
      description = "Webcord with Vencord web extension";
      maintainers = with maintainers; [FlafyDev ludovicopiero NotAShelf];
    };
}))
.override {
  electron_25 = electron_27;
}
