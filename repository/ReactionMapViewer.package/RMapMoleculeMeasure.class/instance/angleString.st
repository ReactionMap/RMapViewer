accessing
angleString
	| p1 p2 p3 |
	p1 := atoms first position.
	p2 := atoms second position.
	p3 := atoms third position.
	^ ((Jun3dLine from: p2 to: p1) angleWithLine: (Jun3dLine from: p2 to: p3)) deg printShowingDecimalPlaces: 3