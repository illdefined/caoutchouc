\RequirePackage
	{ expl3 }

\ExplSyntaxOn
\ProvidesClass
	{ caoutchouc }

\cs_new:Nn
	\caoutchouc_module:n {
		\file_input:n
			{ #1 .tex } }

\caoutchouc_module:n
	{ unique }

\caoutchouc_module:n
	{ encap }

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


\caoutchouc_module:n
	{ fount }

\RequirePackage
	{ polyglossia }

\caoutchouc_module:n
	{ colour }

\caoutchouc_module:n
	{ hyperref }

\caoutchouc_module:n
	{ quotation }

% Miscellaneous packages
\RequirePackage
	{ paralist, units, verbatim, xltxtra }

\caoutchouc_module:n
	{ koma }

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
