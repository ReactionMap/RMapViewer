transformation
transformationBlockWith: anRMapXYZFrame atomMap: map
	| g1 g2 xAxis1 yAxis1 zAxis1 xAxis2 yAxis2 yAxis2l zAxis2l yAxis2r zAxis2r leftBlock rightBlock leftError rightError |
	atoms size <= 1
		ifTrue: [ ^ [ :p | p ] ].
	atoms size = 2
		ifTrue: [
			g1 := self centerOfGravity.
			g2 := anRMapXYZFrame centerOfGravity.
			xAxis1 := ((self pointAt: 2) - (self pointAt: 1)) unit.
			xAxis2 := ((anRMapXYZFrame pointAt: (map at: 2)) - (anRMapXYZFrame pointAt: (map at: 1))) unit.
			^ [ :p | 
			| point x y z |
			point := p - g2.
			x := xAxis2 dot: point.
			xAxis1 * x + g1 ] ].
	g1 := self centerOfGravity.
	g2 := anRMapXYZFrame centerOfGravity.
	xAxis1 := ((self pointAt: 2) - (self pointAt: 1)) unit.
	yAxis1 := ((self pointAt: 3) - (self pointAt: 1)) unit.
	zAxis1 := (xAxis1 cross: yAxis1) unit.
	yAxis1 := (zAxis1 cross: xAxis1) unit.
	xAxis2 := ((anRMapXYZFrame pointAt: (map at: 2)) - (anRMapXYZFrame pointAt: (map at: 1))) unit.
	yAxis2 := ((anRMapXYZFrame pointAt: (map at: 3)) - (anRMapXYZFrame pointAt: (map at: 1))) unit.
	zAxis2l := (xAxis2 cross: yAxis2) unit.
	yAxis2l := (zAxis2l cross: xAxis2) unit.
	zAxis2r := (yAxis2 cross: xAxis2) unit.
	yAxis2r := (xAxis2 cross: zAxis2r) unit.
	leftBlock := [ :p | 
	| point x y z |
	point := p - g2.
	x := xAxis2 dot: point.
	y := yAxis2l dot: point.
	z := zAxis2l dot: point.
	xAxis1 * x + (yAxis1 * y) + (zAxis1 * z) + g1 ].
	rightBlock := [ :p | 
	| point x y z |
	point := p - g2.
	x := xAxis2 dot: point.
	y := yAxis2r dot: point.
	z := zAxis2r dot: point.
	xAxis1 * x + (yAxis1 * y) + (zAxis1 * z) + g1 ].
	leftError := 0.0.
	rightError := 0.0.
	1 to: map size do: [ :index | 
		leftError := leftError
			+ ((self pointAt: index) squaredDist: (leftBlock value: (anRMapXYZFrame pointAt: (map at: index)))).
		rightError := rightError
			+ ((self pointAt: index) squaredDist: (rightBlock value: (anRMapXYZFrame pointAt: (map at: index)))) ].
	^ (leftError <= 1.0e-5 or: [rightError >= 1.0e-5])
		ifTrue: [ leftBlock ]
		ifFalse: [rightBlock ]