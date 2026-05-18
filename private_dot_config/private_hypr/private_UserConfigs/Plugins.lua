hl.config({
	plugin = {
		hyprglass = {
			default_theme = "dark",
			default_preset = "default",
			brightness = 0.9,
			["dark:brightness"] = 0.82,
			["light:adaptive_boost"] = 0.5,
			-- Custom preset: shared + per-theme variants
			preset = {
				"name:clear, glass_opacity:0.8, blur_strength:1.5",
				"name:clear:dark, brightness:0.7",
				"name:clear:light, brightness:1.2",
			},
		},
	},
})
