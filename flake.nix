{
  inputs = {
    idiosyn.url = "git+https://woof.rip/mikael/idiosyn.git";
  };

  nixConfig = {
    extra-experimental-features = [ "pipe-operator" "ca-derivations" ];
    extra-substituters = [ "https://cache.kyouma.net" ];
    extra-trusted-public-keys = [ "cache.kyouma.net:Frjwu4q1rnwE/MnSTmX9yx86GNA/z3p/oElGvucLiZg=" ];
  };

  outputs = { self, nixpkgs, idiosyn, ... }:
  let
    inherit (nixpkgs) lib;
    eachSystem = lib.genAttrs [ "riscv64-linux" "aarch64-linux" "x86_64-linux" ];
  in {
    packages = eachSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = pkgs.callPackage ({
          lib,
          runCommand,
          writeShellScript,
          texlive,
          lato,
          mplus-outline-fonts,
          iosevka-idiosyn,
        }: runCommand "caoutchouc" {
          __structuredAttrs = true;
          __contentAddressed = true;

          outputs = [ "tex" ];
          outputsToInstall = [ ];

          strictDeps = true;

          nativeBuildInputs = [
            (writeShellScript "force-tex-output.sh" ''out="$tex"'')
          ];

          passthru.tlDeps = [
            lato
            mplus-outline-fonts.githubRelease
            iosevka-idiosyn
          ] ++ (with texlive; [
            xetex
            fontspec
            polyglossia

            koma-script

            amsmath
            csquotes
            fontspec
            hyperref
            paralist
            realscripts
            unicode-math
            units
            xecjk
            xecolor
            xltxtra
          ]);

          meta = {
            license = lib.licenses.eupl12;
            platforms = lib.platforms.all;
          };
        } ''
          path="$tex/tex/xelatex/caoutchouc"
          mkdir -p "$path"
          cp ${./.}/*.{cls,tex} "$path"
        '') {
          inherit (idiosyn.packages.${system}) iosevka-idiosyn;
        };
      });

    checks = eachSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        mkTest = {
          class,
          text ? "",
        }: (pkgs.callPackage (pkgs.path + "/pkgs/test/texlive") { }).mkTeXTest {
          name = "caoutchouc-${class}";
          format = "xelatex";
          texLive = pkgs.texliveInfraOnly.withPackages (_: [ self.packages.${system}.default ]);
          text = ''
            \documentclass[class = ${class}]{caoutchouc}
            \begin{document}
            ${text}
            \end{document}
          '';
        };
      in {
        book = mkTest { class = "book"; };
        report = mkTest { class = "report"; };
        article = mkTest { class = "book"; };
        letter = mkTest {
          class = "letter";
          text = ''
            \begin{letter}{~}
            \opening{~}
            \closing{~}
            \end{letter}
          '';
        };
      });
  };
}
