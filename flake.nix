{
  inputs = {
    iosevka.url = "https://woof.rip/mikael/iosevka/archive/main.tar.gz";
    xdvipdfmx.url = "https://woof.rip/mikael/xdvipdfmx/archive/main.tar.gz";
  };

  nixConfig = {
    extra-experimental-features = [ "pipe-operator" ];
    extra-substituters = [ "https://cache.kyouma.net" ];
    extra-trusted-public-keys = [ "cache.kyouma.net:Frjwu4q1rnwE/MnSTmX9yx86GNA/z3p/oElGvucLiZg=" ];
  };

  outputs = { self, nixpkgs, iosevka, xdvipdfmx, ... }:
  let
    inherit (nixpkgs) lib;
    eachSystem = fn: lib.genAttrs lib.systems.flakeExposed (system: fn system nixpkgs.legacyPackages.${system});
  in {
    packages = eachSystem (system: pkgs: {
      default = self.packages.${system}.caoutchouc;
      caoutchouc = pkgs.callPackage ./package.nix {
        inherit self;
        inherit (iosevka.packages.${system})
          iosevka-idiosyn-sans
          iosevka-idiosyn-sans-quasi;
      };

      texlive-caoutchouc = (pkgs.texlive.withPackages (_: [
        self.packages.${system}.caoutchouc
        xdvipdfmx.packages.${system}.xdvipdfmx-wrapper
      ])).override {
        ignoreCollisions = true;
      };
    });

    checks = eachSystem (system: pkgs:
    let
      mkTest = {
        class,
        text ? "",
      }: (pkgs.callPackage (pkgs.path + "/pkgs/test/texlive") { }).mkTeXTest {
        name = "caoutchouc-${class}";
        format = "xelatex";
        texLive = self.packages.${system}.texlive-caoutchouc;
        text = ''
          \DocumentMetadata{lang=en-GB}
          \documentclass{${class}}
          \usepackage{caoutchouc}
          \begin{document}
          ${text}
          \end{document}
        '';
      };
    in {
      minimal = mkTest { class = "minimal"; };
      book = mkTest { class = "scrbook"; };
      report = mkTest { class = "scrreprt"; };
      article = mkTest { class = "scrartcl"; };
      letter = mkTest {
        class = "scrlttr2";
        text = ''
          \begin{letter}{~}
          \opening{~}
          ~
          \closing{~}
          \end{letter}
        '';
      };

      class = mkTest { class = "caoutchouc"; };
    });
  };
}
