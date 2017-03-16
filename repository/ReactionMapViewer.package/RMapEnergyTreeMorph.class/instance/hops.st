private
hops
	^ rmapMorph paths
		ifEmpty: [ 
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
							done add: vertex.
							vertex
								edgesDo: [ :edge | 
									((done includes: edge vertex1) not and: [ rmapMorph isEffectiveVertex: edge vertex1 ])
										ifTrue: [ newAgenda add: edge vertex1 ].
									((done includes: edge vertex2) not and: [ rmapMorph isEffectiveVertex: edge vertex2 ])
										ifTrue: [ newAgenda add: edge vertex2 ] ] ].
					agenda := newAgenda.
					hopCount := hopCount + 1 ].
			hopCount ]
		ifNotEmpty: [ :paths | paths inject: 0 into: [ :sum :path | sum max: path size ] ]