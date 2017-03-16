accessing
dihedralAngleString
	| p1 p2 p3 p4 |
	p1 := atoms first position.
	p2 := atoms second position.
	p3 := atoms third position.
	p4 := atoms fourth position.
	^ ((JunPlane on: p1 on: p2 on: p3) angleWithPlane: (JunPlane on: p2 on: p3 on: p4)) deg printShowingDecimalPlaces: 3