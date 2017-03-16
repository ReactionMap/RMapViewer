drawing
drawVertex: anRMapVertex hop: anInteger color: aColor on: aCanvas
	| x1 x2 y w h |
	x1 := (anInteger + 0.25) * self bandWidth + self left.
	x2 := self bandWidth * 0.5 + x1.
	y := self yAtEnergy: anRMapVertex energy.
	w := font widthOfString: anRMapVertex label.
	h := font height.
	((hoverPoint x between: x1 and: x2) and: [ (hoverPoint y between: y - h - 4 and: y) and: [ (hoverPoint y - y) abs < hoverError ]])
		ifTrue: [ 
			hoverVertex := anRMapVertex.
			hoverError := (hoverPoint y - y) abs.
			hoverHop := anInteger ].
	aCanvas
		line: (x1 + 1) @ (y - 1)
		to: (x2 - 1) @ (y - 1)
		width: 3
		color: aColor.
	w := font widthOfString: anRMapVertex label.
	h := font height.
	aCanvas
		drawString: anRMapVertex label
		at: (self bandWidth * 0.25 + x1 - (w / 2.0)) @ (y - h - 2)
		font: font
		color: aColor