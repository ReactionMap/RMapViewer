drawing
drawEdge: anRMapEdge color: aColor on: aCanvas
	(rmap isEffectiveEdge: anRMapEdge )
		ifTrue: [ 
			self
				edgePointsBetween: anRMapEdge vertex1
				and: anRMapEdge vertex2
				do: [ :p1 :p2 | 
					(p1 notNil
						and: [ 
							p2 notNil
								and: [ 
									((p1 x between: 0.0 and: rmap width) and: [ p1 y between: 0.0 and: rmap height ])
										or: [ (p2 x between: 0.0 and: rmap width) and: [ p2 y between: 0.0 and: rmap height ] ] ] ])
						ifTrue: [ 
							aCanvas
								line: p1
								to: p2
								width: 1
								color: Color black ] ] ]