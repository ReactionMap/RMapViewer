drawing
drawHoverVertex: anRMapVertex hop: anInteger on: aCanvas
	| x1 y h |
	x1 := anInteger + 0.25 * self bandWidth + self left.
	y := self yAtEnergy: anRMapVertex energy.
	h := font height.
	aCanvas frameRectangle: ((x1)@(y- h - 2) extent: (self bandWidth * 0.5)@(h + 3)) width: 2 color: Color black.
	hoverVertex := anRMapVertex