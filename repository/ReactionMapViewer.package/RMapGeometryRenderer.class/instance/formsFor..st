accessing
formsFor: anRMapVertex
	| xmin ymin xmax ymax zmin zmax width height offset |
	xmin := Float fmax.
	ymin := Float fmax.
	zmin := Float fmax.
	xmax := Float fmin.
	ymax := Float fmin.
	zmax := Float fmin.
	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			xmin := xmin min: x.
			ymin := ymin min: y.
			zmin := zmin min: z.
			xmax := xmax max: x.
			ymax := ymax max: y.
			zmax := zmax max: z ].
	width := ((((xmax - xmin) * (xmax - xmin) + ((zmax - zmin) * (zmax - zmin))) sqrt + 2.0) * atomDiameter) ceiling.
	height := (ymax - ymin + 2.0) ceiling * atomDiameter.
	offset := width @ height // 2.
	^ (0 to: 11)
		collect: [ :angleIndex | 
			| angle form |
			angle := angleIndex asFloat / 6.0 * Float pi.
			form := Form extent: width @ height depth: 32.
			form fillColor: Color transparent.
			form getCanvas
				in: [ :canvas | 
					| positions atoms |
					canvas fillOval: (width @ height // 4 extent: width @ height // 2) color: Color white.
					positions := OrderedCollection new: anRMapVertex geometry size.
					atoms := OrderedCollection new: anRMapVertex geometry size.
					anRMapVertex
						geometryDo: [ :atom :x :y :z | 
							| screenPoint |
							screenPoint := ((angle cos * x + (angle sin * z)) * atomDiameter) @ (y * atomDiameter) + offset.
							positions add: screenPoint.
							atoms add: (Array with: angle sin * x + (angle cos * z) with: screenPoint with: (self atomColorAt: atom)) ].
					anRMapVertex
						bondsDo: [ :a1 :a2 :type | 
							type odd
								ifTrue: [ 
									type to: 1 by: -1 do: [ :i | 
										| p1 p2 v |
										p1 := positions at: a1.
										p2 := positions at: a2.
										v := p2 - p1.
										v := (4.0 + (i * 2 - 1)) / v r * v.
										canvas
											line: p1 + v
											to: p2 - v
											width: i * 2 - 1
											color:
												(i odd
													ifTrue: [ Color black ]
													ifFalse: [ Color white ]) ] ]
								ifFalse: [ 
									type to: 1 by: -1 do: [ :i | 
										| p1 p2 v |
										p1 := positions at: a1.
										p2 := positions at: a2.
										v := p2 - p1.
										v := (4.0 + (i * 2 - 1)) / v r * v.
										canvas
											line: p1 + v
											to: p2 - v
											width: i * 2 - 1
											color:
												(i even
													ifTrue: [ Color black ]
													ifFalse: [ Color white ]) ] ] ].
					(atoms asSortedCollection: [ :deeper :shallower | deeper first <= shallower first ])
						do: [ :triple | 
							canvas
								fillOval: (triple second - (atomDiameter / 2.0) extent: atomDiameter asPoint)
								color: triple third
								borderWidth: 1
								borderColor: Color black ] ].
			form ]