\NeedsTeXFormat{LaTeX2e}[2023-11-01]
\ProvidesExplClass{caoutchouc}{1980-01-01}{0.0.0}
	{caoutchouc compatibility class}

\str_new:N \g__caoutchouc_class_str
\cs_new_protected:Nn \__caoutchouc_class:n {
	\str_gset:Nn \g__caoutchouc_class_str { #1 }
}

\keys_define:nn { caoutchouc } {
	class .choice:,
	class / book .code:n = { \__caoutchouc_class:n { scrbook } },
	class / report .code:n = { \__caoutchouc_class:n { scrreprt } },
	class / article .code:n = { \__caoutchouc_class:n { scrartcl } },
	class / letter .code:n = { \__caoutchouc_class:n { scrlttr2 } },
	class .initial:n = { article },
}

\ProcessKeyOptions
\LoadClass { \g__caoutchouc_class_str }
\RequirePackage { caoutchouc }
