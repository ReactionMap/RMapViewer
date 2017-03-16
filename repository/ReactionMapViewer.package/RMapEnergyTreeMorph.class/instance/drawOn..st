drawing
drawOn: aCanvas
	aCanvas fillRectangle: self bounds color: Color white.
	hoverError := TextStyle defaultFont height.
	hoverHop := nil.
	hoverPoint := self globalPointToLocal: ActiveHand position.
	(self yAtEnergy: rmapMorph visibleEnergyRangeMax)
		in: [ :y | aCanvas line: self left @ y to: self right @ y color: Color red ].
	(self yAtEnergy: rmapMorph visibleEnergyRangeMin)
		in: [ :y | aCanvas line: self left @ y to: self right @ y color: Color red ].
	rmapMorph paths
		ifEmpty: [ self drawHopsOn: aCanvas color: Color lightGray ]
		ifNotEmpty: [ self drawPathsOn: aCanvas color: Color black ].
	hoverHop ifNotNil: [ self drawHoverVertex: hoverVertex hop: hoverHop on: aCanvas ] ifNil: [ hoverVertex := nil ]