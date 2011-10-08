\ProvidesClass
	{caoutchouc}

% Require XeTeX
\RequirePackage
	{ifxetex}
\RequireXeTeX

\RequirePackage
	{etoolbox}

\RequirePackage
	{xkeyval}

\define@choicekey
	{\XKV@documentclass}
	{class}[\val\nr]
	{book, report, article, letter}
	{\newcommand*
		{\@class}
		{\ifcase\nr
			scrbook\or
			scrreprt\or
			scrartcl\or
			scrlttr2\fi}}

\ProcessOptionsX

\LoadClass
	[parskip = half]
	{\@class}

% Fount settings
\RequirePackage
	{fontspec}

\defaultfontfeatures
	{Mapping = tex-text}

\newcommand*
	{\@slant}
	{FakeSlant = 0.1}

\newcommand*
	{\@mplus}[1]
	{UprightFont = * 2#1 regular,
		SlantedFont = * 2#1 regular,
		ItalicFont = * 1#1 regular,
		BoldFont = * 2#1 bold,
		BoldSlantedFont = * 2#1 bold,
		BoldItalicFont = * 1#1 bold,
		SlantedFeatures = {\@slant},
		ItalicFeatures = {\@slant},
		BoldSlantedFeatures = {\@slant},
		BoldItalicFeatures = {\@slant}}

\setsansfont
	[\@mplus{c}]{M+}
\setmonofont
	[\@mplus{m}]{M+}

% Set the default family to sans-serif
\renewrobustcmd*
	{\familydefault}
	{\sfdefault}

% Mathematics
\RequirePackage
	{amsmath}
\RequirePackage
	[math-style = upright]
	{unicode-math}

\setmathfont
	{STIXGeneral}
\setmathfont
	[range =
		{\mathup/{latin, Latin, greek, Greek, num},
			\mathsf/{latin, Latin, greek, Greek, num}}]
	{M+ 2c regular}
\setmathfont
	[range = {\mathit/{latin, Latin, greek, Greek, num}},
		UprightFeatures = {\@slant}]
	{M+ 1c regular}
\setmathfont
	[range = {\mathtt/{latin, Latin, greek, Greek, num}}]
	{M+ 2m regular}


\RequirePackage
	{polyglossia}

% Colours
\RequirePackage
	[hyperref]
	{xcolor}

% Command aliases
\newrobustcmd*
	{\definecolour}
	{\definecolor}
\newrobustcmd*
	{\providecolour}
	{\providecolor}
\newrobustcmd*
	{\colourlet}
	{\colorlet}
\newrobustcmd*
	{\colour}
	{\color}
\newrobustcmd*
	{\textcolour}
	{\textcolor}

\definecolour
	{PrussianBlue}
	{rgb}{0, 0.19140625, 0.32421875}
\definecolour
	{MidnightGreen}
	{rgb}{0, 0.28515625, 0.32421875}
\definecolour
	{PhthaloGreen}
	{rgb}{0.0703125, 0.20703125, 0.140625}
\definecolour
	{BerlinBlue}
	{rgb}{0.13671875, 0.171875, 0.24609375}
\definecolour
	{DarkSlateGrey}
	{rgb}{0.18359375, 0.30859375, 0.30859375}
\definecolour
	{TyrianPurple}
	{rgb}{0.3984375, 0.0078125, 0.234375}
\definecolour
	{Sangria}
	{rgb}{0.5703125, 0, 0.0390625}

\colourlet
	{emphasis}
	{TyrianPurple}
\colourlet
	{hyperref}
	{BerlinBlue}
\colourlet
	{strong}
	{Sangria}

\RequirePackage
	[colorlinks = true,
		allcolors = hyperref
		unicode = true,
		pdfdisplaydoctitle = true]
	{hyperref}

\AfterPreamble
	{\hypersetup
		{pdftitle = {\@title},
			pdfauthor = {\@author},
			pdfsubject = {\@subject}}}

% hyperref language fixes
\renewrobustcmd*
	{\equationautorefname}
	{\equationname}
\renewrobustcmd*
	{\footnoteautorefname}
	{\Hfootnotename}
\renewrobustcmd*
	{\itemautorefname}
	{\Itemname}
\renewrobustcmd*
	{\figureautorefname}
	{\figurename}
\renewrobustcmd*
	{\tableautorefname}
	{\tablename}
\renewrobustcmd*
	{\partautorefname}
	{\partname}
\renewrobustcmd*
	{\appendixautorefname}
	{\appendixname}
\renewrobustcmd*
	{\chapterautorefname}
	{\chaptername}
\renewrobustcmd*
	{\sectionautorefname}
	{\sectionname}
\renewrobustcmd*
	{\subsectionautorefname}
	{\subsectionname}
\renewrobustcmd*
	{\subsubsectionautorefname}
	{\subsubsectionname}
\renewrobustcmd*
	{\paragraphautorefname}
	{\paragraphname}
\renewrobustcmd*
	{\subparagraphautorefname}
	{\subparagraphname}
\renewrobustcmd*
	{\FancyVerbLineautorefname}
	{\FancyVerbLinename}
\renewrobustcmd*
	{\theoremautorefname}
	{\theoremname}
\renewrobustcmd*
	{\pageautorefname}
	{\page}

% Miscellaneous packages
\RequirePackage
	{paralist, units, verbatim, xltxtra}

% Highlighting
\renewrobustcmd*
	{\emph}[1]
	{\textcolour{emphasis}{\em #1}}
\newrobustcmd*
	{\strong}[1]
	{\textcolour{strong}{\bfseries #1}}

\widowpenalty=9999
\clubpenalty=9999
