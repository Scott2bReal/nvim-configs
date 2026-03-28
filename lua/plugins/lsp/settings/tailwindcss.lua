return {
	settings = {
		tailwindCSS = {
			lint = {
				suggestCanonicalClasses = "ignore",
			},
			experimental = {
				classRegex = {
					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "tw\\('([^']*)'\\)" },
				},
			},
		},
	},
}
