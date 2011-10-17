\RequirePackage
	{ expl3 }

\ExplSyntaxOn
\ProvidesClass
	{ caoutchouc }

\int_new:N
	\g_caoutchouc_unique_int

\cs_new:Nn
	\caoutchouc_unique_step:N {
		\tl_set:Nx
			#1 {
			caoutchouc_unique__
			\int_to_alph:n {
				\int_use:N
					\g_caoutchouc_unique_int } }
		\int_gincr:N
			\g_caoutchouc_unique_int }

\cs_new:Nn
	\caoutchouc_unique:N {
		\caoutchouc_unique_step:N
			#1
		\bool_while_do:nn {
			\cs_if_exist_p:c
				{ #1 } } {
			\caoutchouc_unique_step:N
				#1 } }

\cs_new:Nn
	\caoutchouc_encap:NNn {
		\tl_set_eq:NN
			#2 #1
		\tl_set:Nn
			#1 { #3 }
		\tl_replace_all:Nnn
			#1 { #1 } { #2 }
	}

\cs_generate_variant:Nn
	\caoutchouc_encap:NNn
		{ Ncn }

\cs_new:Nn
	\caoutchouc_encap:Nn {
		\caoutchouc_unique:N
			\l_tmpa_tl
		\caoutchouc_encap:Ncn
			#1
			{ \l_tmpa_tl }
			{ #2 }
	}

\cs_new:Nn
	\caoutchouc_colour:Nn {
		\caoutchouc_encap:Nn
			#1 {
			\color_group_begin:
				\colour
					{ #2 }
				#1
			\color_group_end:
		}
	}

\RequirePackage
	{ l3keys2e }

\keys_define:nn
	{ caoutchouc } {
		class .choice:,
		class / book .code:n = {
			\tl_set:Nn
				\g_caoutchouc_class
				{ scrbook }},
		class / report .code:n = {
			\tl_set:Nn
				\g_caoutchouc_class
				{ scrreprt }},
		class / article .code:n = {
			\tl_set:Nn
				\g_caoutchouc_class
				{ scrartcl }},
		class / letter .code:n = {
			\tl_set:Nn
				\g_caoutchouc_class
				{ scrlttr2 }}}

\keys_set:nn
	{ caoutchouc }
	{ class = article }

\ProcessKeysOptions
	{ caoutchouc }

\LoadClass
	[ parskip = half ]
	{ \g_caoutchouc_class }

% Fount settings
\RequirePackage
	{ fontspec }

\defaultfontfeatures {
	Mapping = tex-text
}

\setmainfont
	{ Latin~Modern~Roman }
\setsansfont
	{ Latin~Modern~Sans }
\setmonofont
	{ Latin~Modern~Mono }

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
	{ Latin~Modern~Math }

% CJK fount settings
\RequirePackage [
		CJKnumber,
		SlantFont ]
	{ xeCJK }

\setCJKmainfont [
		UprightFont = { *~regular },
		BoldFont = { *~bold } ]
	{ M+~2c }
\setCJKsansfont [
		UprightFont = { *~regular },
		BoldFont = { *~bold } ]
	{ M+~2c }

\normalspacedchars
	{ „“”‚‘’ }

\RequirePackage
	{ ruby }

\tl_set:Nn
	\rubysep
	{ 0ex }

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
	{ disposition }
	{ PrussianBlue }
\colourlet
	{ emphasis }
	{ TyrianPurple }
\colourlet
	{ hyperref }
	{ BerlinBlue }
\colourlet
	{ pagination }
	{ DarkSlateGrey }
\colourlet
	{ quotation }
	{ PhthaloGreen }
\colourlet
	{ strong }
	{ Sangria }

\RequirePackage [
		colorlinks = true,
		allcolors = hyperref,
		unicode = true,
		pdfdisplaydoctitle = true ]
	{ hyperref }

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

% Adjust KOMA-script formatting
\setotherlanguage
	[ variant = ancient ]
	{ greek }

\@ifclassloaded
	{ scrlttr2 }
	{ } {
		\addtokomafont
			{ disposition } {
				\colour
					{ disposition }}
	}
\addtokomafont
	{ pagination } {
		\colour
			{ pagination }}

\caoutchouc_colour:Nn
	\thepart
	{ pagination }
\caoutchouc_colour:Nn
	\thechapter
	{ pagination }
\caoutchouc_colour:Nn
	\thesection
	{ pagination }
\caoutchouc_colour:Nn
	\thesubsection
	{ pagination }
\caoutchouc_colour:Nn
	\thesubsubsection
	{ pagination }
\caoutchouc_colour:Nn
	\theparagraph
	{ pagination }
\caoutchouc_colour:Nn
	\thesubparagraph
	{ pagination }
\caoutchouc_colour:Nn
	\thefigure
	{ pagination }
\caoutchouc_colour:Nn
	\thetable
	{ pagination }
\caoutchouc_colour:Nn
	\thefootnote
	{ pagination }
\caoutchouc_colour:Nn
	\thempfootnote
	{ pagination }

\caoutchouc_colour:Nn
	\labelenumi
	{ pagination }
\caoutchouc_colour:Nn
	\labelenumii
	{ pagination }
\caoutchouc_colour:Nn
	\labelenumiii
	{ pagination }
\caoutchouc_colour:Nn
	\labelenumiv
	{ pagination }

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

\widowpenalty = 10000
\clubpenalty = 10000
\hyphenpenalty = 2500
\tolerance = 1000

% vim:ft=tex
