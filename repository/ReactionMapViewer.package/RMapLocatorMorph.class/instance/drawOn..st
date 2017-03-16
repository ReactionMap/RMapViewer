drawing
drawOn: aCanvas
	aCanvas
		clipBy: self bounds
		during: [ :canvas | 
			canvas fillRectangle: self bounds color: Color white.
			rmapMorph
				verticesDo: [ :vertex | 
					(rmapMorph xNumerizer value: vertex)
						ifNotNil: [ :x | 
							(rmapMorph yNumerizer value: vertex)
								ifNotNil: [ :y | canvas fillRectangle: (x @ (1.0 - y) * (self extent - 10) + self position + 5 extent: 1 @ 1) color: Color black ] ] ].
			rmapMorph projector bounds
				in: [ :rect | 
					canvas
						frameRectangle:
							(((rect left @ (1.0 - rect bottom) extent: rect extent) scaleBy: self extent - 10) translateBy: self position + 5)
						color: Color red ] ]