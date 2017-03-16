drawing
drawHopsOn: aCanvas color: aColor
	| agenda done hopCount |
	agenda := OrderedCollection new.
	done := Set new: 1024.
	rmapMorph
		reactantsDo: [ :vertex | 
			(rmapMorph isEffectiveVertex: vertex)
				ifTrue: [ agenda add: vertex ] ].
	hopCount := 0.
	[ agenda notEmpty ]
		whileTrue: [ 
			| newAgenda |
			newAgenda := OrderedCollection new: 1024.
			agenda
				do: [ :vertex | 
					self
						drawVertex: vertex
						hop: hopCount
						color: aColor
						on: aCanvas.
					done add: vertex.
					vertex
						edgesDo: [ :edge | 
							((done includes: edge vertex1) not and: [ rmapMorph isEffectiveVertex: edge vertex1 ])
								ifTrue: [ 
									self
										drawEdgeFrom: vertex
										to: edge vertex1
										hop: hopCount
										color: aColor
										on: aCanvas.
									newAgenda add: edge vertex1 ].
							((done includes: edge vertex2) not and: [ rmapMorph isEffectiveVertex: edge vertex2 ])
								ifTrue: [ 
									self
										drawEdgeFrom: vertex
										to: edge vertex2
										hop: hopCount
										color: aColor
										on: aCanvas.
									newAgenda add: edge vertex2 ] ] ].
			agenda := newAgenda.
			hopCount := hopCount + 1 ]