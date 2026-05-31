{ config, pkgs, lib, ... }:

let
  epiclang = pkgs.rustPlatform.buildRustPackage {
    pname = "epiclang";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "EpiSdk";
      repo = "EpiFaster";
      rev = "0d204fe62bf90498644e5f24eb8eb53616e45d6c";
      hash = "sha256-klTqsW6pzrlxoRhh/4DoVtMYEOkt62Hu+o4SKobJAV4=";
    };

    cargoHash = "sha256-LoSEGRgS/AuGk2KCEZKqDskPm083Jj59OtBShvBWxtQ=";

    postInstall = ''
        mkdir -p $out/lib/epiclang/plugins
        cp $src/plugins/*.so $out/lib/epiclang/plugins/
    '';
  };
in
{
  home.packages = [ epiclang ];

  home.file.".local/lib/epiclang/plugins".source =
      "${epiclang}/lib/epiclang/plugins";
}