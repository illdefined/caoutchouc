\RequirePackage
	{ expl3 }

\ExplSyntaxOn
\ProvidesClass
	{ caoutchouc }

\RequirePackage
	{ l3keys2e }

\keys_define:nn
	{ caoutchouc } {
		class .choice:,
		class / book .code:n = {
			\tl_set:Nn
				\caoutchouc_class
				{ scrbook }},
		class / report .code:n = {
			\tl_set:Nn
				\caoutchouc_class
				{ scrreprt }},
		class / article .code:n = {
			\tl_set:Nn
				\caoutchouc_class
				{ scrartcl }},
		class / letter .code:n = {
			\tl_set:Nn
				\caoutchouc_class
				{ scrlttr2 }}}

\ProcessKeysOptions
	{ caoutchouc }

\LoadClass
	[ parskip = half ]
	{ \caoutchouc_class }

% Fount settings
\RequirePackage
	{ fontspec }

\defaultfontfeatures
	{ Mapping = tex-text }

\cs_new:Nn
	\caoutchouc_slant:
		{ FakeSlant = 0.1 }

\cs_new:Nn
	\caoutchouc_mplus:n {
		UprightFont = *~2#1~regular,
		SlantedFont = *~2#1~regular,
		ItalicFont = *~1#1~regular,
		BoldFont = *~2#1~bold,
		BoldSlantedFont = *~2#1~bold,
		BoldItalicFont = *~1#1~bold,
		SlantedFeatures = { \caoutchouc_slant: },
		ItalicFeatures = { \caoutchouc_slant: },
		BoldSlantedFeatures = { \caoutchouc_slant: },
		BoldItalicFeatures = { \caoutchouc_slant: }}

\setsansfont
	[ \caoutchouc_mplus:n c ]
	{ M+ }
\setmonofont
	[ \caoutchouc_mplus:n m ]
	{ M+ }

% Set the default family to sans-serif
\tl_set:Nn
	\familydefault
	\sfdefault

% Mathematics
\RequirePackage
	{ amsmath }
\RequirePackage
	[ math-style = upright ]
	{ unicode-math }

\setmathfont
	{ STIXGeneral }
\setmathfont [
	range = {
		\mathup / { latin, Latin, greek, Greek, num },
		\mathsf / { latin, Latin, greek, Greek, num }}]
	{ M+~2c~regular }
\setmathfont [
	range = {
		\mathit / { latin, Latin, greek, Greek, num }},
	UprightFeatures = { \caoutchouc_slant: }]
	{ M+~1c~regular }
\setmathfont [
	range = {
		\mathtt / { latin, Latin, greek, Greek, num }}]
	{ M+~2m~regular }

\RequirePackage
	{ polyglossia }

% Colours
\RequirePackage
	[ hyperref ]
	{ xcolor }

% Command aliases
\tl_set:Nn
	\definecolour
	\definecolor
\tl_set:Nn
	\providecolour
	\providecolor
\tl_set:Nn
	\colourlet
	\colorlet
\tl_set:Nn
	\colour
	\color
\tl_set:Nn
	\textcolour
	\textcolor

\definecolour
	{ PrussianBlue }
	{ rgb }
	{ 0, 0.19140625, 0.32421875 }
\definecolour
	{ MidnightGreen }
	{ rgb }
	{ 0, 0.28515625, 0.32421875 }
\definecolour
	{ PhthaloGreen }
	{ rgb }
	{ 0.0703125, 0.20703125, 0.140625 }
\definecolour
	{ BerlinBlue }
	{ rgb }
	{ 0.13671875, 0.171875, 0.24609375 }
\definecolour
	{ DarkSlateGrey }
	{ rgb }
	{ 0.18359375, 0.30859375, 0.30859375 }
\definecolour
	{ TyrianPurple }
	{ rgb }
	{ 0.3984375, 0.0078125, 0.234375 }
\definecolour
	{ Sangria }
	{ rgb }
	{ 0.5703125, 0, 0.0390625 }

\colourlet
	{ emphasis }
	{ TyrianPurple }
\colourlet
	{ hyperref }
	{ BerlinBlue }
\colourlet
	{ quotation }
	{ PhthaloGreen }
\colourlet
	{ strong }
	{ Sangria }

\RequirePackage [
		colorlinks = true,
		allcolors = hyperref
		unicode = true,
		pdfdisplaydoctitle = true ]
	{ hyperref }

\AtBeginDocument {
	\hypersetup {
		pdftitle = { \@title },
		pdfauthor = { \@author },
		pdfsubject = { \@subject }}}

% hyperref language fixes
\tl_set:Nn
	\equationautorefname
	\equationname
\tl_set:Nn
	\footnoteautorefname
	\Hfootnotename
\tl_set:Nn
	\itemautorefname
	\Itemname
\tl_set:Nn
	\figureautorefname
	\figurename
\tl_set:Nn
	\tableautorefname
	\tablename
\tl_set:Nn
	\partautorefname
	\partname
\tl_set:Nn
	\appendixautorefname
	\appendixname
\tl_set:Nn
	\chapterautorefname
	\chaptername
\tl_set:Nn
	\sectionautorefname
	\sectionname
\tl_set:Nn
	\subsectionautorefname
	\subsectionname
\tl_set:Nn
	\subsubsectionautorefname
	\subsubsectionname
\tl_set:Nn
	\paragraphautorefname
	\paragraphname
\tl_set:Nn
	\subparagraphautorefname
	\subparagraphname
\tl_set:Nn
	\FancyVerbLineautorefname
	\FancyVerbLinename
\tl_set:Nn
	\theoremautorefname
	\theoremname
\tl_set:Nn
	\pageautorefname
	\page

% Quotation
\RequirePackage
	{ csquotes }

\tl_set_eq:NN
	\caoutchouc_enquote
	\enquote

\DeclareDocumentCommand
	\enquote { m } {
		\caoutchouc_enquote {
			\textcolour
				{ quotation }
				{ #1 }}}

\DeclareDocumentCommand
	\mkcitation { m }
	{ #1\,\footnote }
\DeclareDocumentCommand
	\mktextquote { m m m m m m } {
		#1 \textcolour
			{ quotation }
			{ #2 #4 }
		#3 #6 #5 }
\DeclareDocumentCommand
	\mkblockquote { m m } {
		\color_group_begin:
			\colour
				{ quotation }
			#1 #2
		\color_group_end: }
\DeclareDocumentCommand
	\mkbegdispquote { m m }
	{ \color_group_begin:
		\colour
			{ quotation }}
\DeclareDocumentCommand
	\mkenddispquote { m m }
		{ #1 #2 \color_group_end: }

% Miscellaneous packages
\RequirePackage
	{ paralist, units, verbatim, xltxtra }

% Highlighting
\DeclareDocumentCommand
	\emph { m } {
		\textcolour
			{ emphasis }
			{ \em #1 }}
\DeclareDocumentCommand
	\strong { m } {
		\textcolour
			{ strong }
			{ \bfseries #1 }}

\widowpenalty = 9999
\clubpenalty = 9999

% vim:ft=tex
