accessing
formsFor: anRMapVertex
	| atoms positions zs offset extent form font |
	atoms := OrderedCollection new: anRMapVertex geometry size.
	positions := OrderedCollection new: anRMapVertex geometry size.
	zs := OrderedCollection new: anRMapVertex geometry size.
	self
		geometry2d: anRMapVertex
		do: [ :atom :x :y :z | 
			atoms add: atom.
			positions add: x @ y.
			zs add: z ].
	anRMapVertex
		bondsDo: [ :i1 :i2 :type | 
			| a1 a2 |
			a1 := atoms at: i1.
			a2 := atoms at: i2.
			(a1 = 'O' and: [ a2 = 'H' ])
				ifTrue: [ atoms at: i1 put: 'OH' ].
			(a2 = 'O' and: [ a1 = 'H' ])
				ifTrue: [ atoms at: i2 put: 'OH' ] ].
	offset := positions min - 1.
	positions := positions collect: [ :p | (p - offset) * atomDiameter ].
	font := TextStyle default defaultFont.
	extent := 0 @ font height + atomDiameter + positions max.
	form := Form extent: extent depth: 32.
	form fillColor: Color white.
	form getCanvas
		in: [ :canvas | 
			anRMapVertex
				bondsDo: [ :a1 :a2 :type | 
					((atoms at: a1) = 'H' or: [ (atoms at: a2) = 'H' ])
						ifFalse: [ 
							type odd
								ifTrue: [ 
									type to: 1 by: -1 do: [ :i | 
										| p1 p2 v |
										p1 := positions at: a1.
										p2 := positions at: a2.
										v := p2 - p1.
										v := (4.0 + (i * 2 - 1)) / v r * v.
										canvas
											line: p1
											to: p2
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
											line: p1
											to: p2
											width: i * 2 - 1
											color:
												(i even
													ifTrue: [ Color black ]
													ifFalse: [ Color white ]) ] ] ] ].
			((1 to: positions size) asSortedCollection: [ :less :more | (zs at: less) <= (zs at: more) ])
				do: [ :i | 
					| atom rect |
					atom := atoms at: i.
					(#('C' 'H') includes: atom)
						ifFalse: [ 
							rect := Rectangle center: (positions at: i) extent: (font widthOfString: atom) @ font height.
							canvas fillRectangle: rect color: Color white.
							canvas drawString: atom at: rect origin ] ].
			canvas
				drawString: anRMapVertex label
				at: ((form width - (font widthOfString: anRMapVertex label)) // 2) @ (form height - font height - 2).
			canvas frameRectangle: (0@0 extent: form extent) color: Color lightGray ].
	^ Array with: form