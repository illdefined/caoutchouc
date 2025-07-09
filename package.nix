{
  self,
  lib,
  stdenvNoCC,
  writeShellScript,
  texlive,
  iosevka-idiosyn-sans,
  iosevka-idiosyn-sans-quasi,
  mplus-outline-fonts,
  noto-fonts-cjk-sans,
}: stdenvNoCC.mkDerivation {
  __structuredAttrs = true;

  pname = "caoutchouc";
  version = "0.0.0";

  src = self;

  outputs = [ "tex" ];
  outputsToInstall = [ ];

  strictDeps = true;

  nativeBuildInputs = [
    (writeShellScript "force-tex-output.sh" ''out="$tex"'')
  ];

  passthru.tlDeps = [
    iosevka-idiosyn-sans
    iosevka-idiosyn-sans-quasi
    mplus-outline-fonts.githubRelease
    noto-fonts-cjk-sans
  ] ++ (with texlive; [
    # Driver
    xetex

    # Document meta‐data and tagging
    latex-lab-dev
    tagpdf
    pdfmanagement-testphase

    # PDF generation
    xcolor
    hyperref
    colorprofiles
    bookmark

    # Founts
    fontspec
    unicode-math
    lato
      fontaxes
    realscripts
    lete-sans-math
    realscripts
    xecjk

    # TOC style
    koma-script

    # Multilingualisation
    polyglossia
      hyphen-english
      hyphen-german
      hyphen-french
      hyphen-spanish
      hyphen-portuguese
      hyphen-russian
      hyphen-latin
      hyphen-ancientgreek
      hyphen-greek
    datetime2
    phonenumbers

    # Fractions & units
    xfrac
    siunitx

    # Tables
    tabularray
      ninecolors
    booktabs
    diagbox
      pict2e
    varwidth

    # Quotation
    csquotes

    # Cross‐references
    cleveref
  ]);

  doConfigure = false;
  doBuild = false;

  postPatch = let
    lastmod = (lib.substring 0 4 self.lastModifiedDate)
      + "-" + (lib.substring 4 2 self.lastModifiedDate)
      + "-" + (lib.substring 6 2 self.lastModifiedDate);
  in ''
    sed -i 's/1980-01-01/${lastmod}/' *.{cls,ldf,sty,tex}
  '';

  installPhase = ''
    runHook preInstall

    path="$tex/tex/xelatex/caoutchouc"
    mkdir -p "$path"
    cp *.{cls,sty,tex} "$path"

    path="$tex/tex/latex/polyglossia"
    mkdir -p "$path"
    cp *.ldf "$path"

    runHook postInstall
  '';

  meta = {
    description = "Personal LaTeX playground";
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ mvs ];
    license = lib.licenses.eupl12;
  };
}
