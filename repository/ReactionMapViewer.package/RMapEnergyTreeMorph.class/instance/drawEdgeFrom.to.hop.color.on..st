drawing
drawEdgeFrom: anRMapVertex1 to: anRMapVertex2 hop: anInteger color: aColor on: aCanvas
	| x1 x2 y1 y2 |
	x1 := anInteger + 0.75 * self bandWidth + self left.
	x2 := self bandWidth * 0.5 + x1.
	y1 := self yAtEnergy: anRMapVertex1 energy.
	y2 := self yAtEnergy: anRMapVertex2 energy.
	aCanvas line: x1@y1 to: x2@y2 color: aColor