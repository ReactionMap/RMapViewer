drawing
drawVertex: anRMapVertex borderColor: aColor on: aCanvas
	^ (rmap isEffectiveVertex: anRMapVertex)
		ifTrue: [ 
			(rmap projector value: anRMapVertex)
				ifNotNil: [ :p | 
					((p x between: 0.0 and: rmap width asFloat) and: [ p y between: 0.0 and: rmap height asFloat ])
						ifTrue: [ 
							| label rect |
							label := self formFor: anRMapVertex.
							label
								ifNotNil: [ 
									rect := p - (label extent / 2.0 + 2) extent: label extent + 4.
									aColor ifNotNil: [ aCanvas frameRectangle: rect width: 2 color: aColor ].
									aCanvas paintImage: label at: p - (label extent / 2.0).
									rect ] ]
						ifFalse: [ nil ] ] ]