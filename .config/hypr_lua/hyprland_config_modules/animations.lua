--------------------
---- ANIMATIONS ----
--------------------

hl.config({
	animations = {
		enabled = true,
	},
})

-- Beziers: hl.curve( NAME, { type = "bezier", points = { {X0, Y0}, {X1, Y1} } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("bouncy", { type = "bezier", points = { { 0.05, 0.93 }, { 0.1, 1.03 } } })
hl.curve("fade", { type = "bezier", points = { { 0.65, 0.05 }, { 0.4, 0.6 } } })
hl.curve("default", { type = "bezier", points = { { 0.12, 0.92 }, { 0.08, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.18, 0.95 }, { 0.22, 1.03 } } })
hl.curve("popin", { type = "bezier", points = { { 0, 1.3 }, { 1, 1 } } })
hl.curve("smoothResize", { type = "bezier", points = { { 0, 0 }, { 0, 1.28 } } })

-- hl.animation({ leaf = STRING, enabled = BOOL, speed = FLOAT, bezier = STRING, style = STRING })
-- Fading
hl.animation({ leaf = "fade", enabled = true, speed = 1.9, bezier = "default" })
-- Windows
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "popin", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "popin", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "smoothResize" })
-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshot", style = "slide" })
-- Borders
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "linear" })
hl.animation({ leaf = "borderangle", enabled = false })
