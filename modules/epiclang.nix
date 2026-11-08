{
  config,
  pkgs,
  lib,
  ...
}:

let
  epiclang = pkgs.rustPlatform.buildRustPackage rec {
    pname = "epiclang";
    version = "1.1.3";

    src = pkgs.fetchFromGitHub {
      owner = "EpiSdk";
      repo = "EpiFaster";
      tag = "v${version}";
      hash = "sha256-SLVgpWEXoIl/DuQkveRx3xSj6xfD2W/qvmx0H9d4b5M=";
    };

    cargoHash = "sha256-LoSEGRgS/AuGk2KCEZKqDskPm083Jj59OtBShvBWxtQ=";
    nativeBuildInputs = [ pkgs.patchelf ];


    postInstall = ''
      mkdir -p $out/lib/epiclang/plugins
      if [ -d "plugins" ]; then
        cp plugins/*.so $out/lib/epiclang/plugins/
      elif [ -d "$src/plugins" ]; then
        cp $src/plugins/*.so $out/lib/epiclang/plugins/
      fi

      for plugin in $out/lib/epiclang/plugins/*.so; do
        if [ -f "$plugin" ]; then
          echo "Patching RPATH for $plugin..."
          patchelf --set-rpath "${lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib pkgs.llvmPackages_21.clang-unwrapped ]}" "$plugin"
        fi
      done
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    epiclang
    llvmPackages_21.clang
    llvmPackages_21.llvm
    
  ];

  systemd.tmpfiles.rules = [
    "L+ /opt/epiclang/plugins - - - - ${epiclang}/lib/epiclang/plugins"
  ];
}
