drawing
drawOn: aCanvas
	form
		ifNil: [ 
			form := Form extent: self extent depth: 32.
			form getCanvas
				in: [ :canvas | 
					| newHoverVertex visibleVertices handPosition |
					canvas fillColor: Color white.
					edges do: [ :edge | self renderer drawEdge: edge color: Color black on: canvas ].
					newHoverVertex := nil.
					handPosition := ActiveHand position - self position.
					visibleVertices := ((vertices select: [ :v | (self isEffectiveVertex: v) and: [ | p | p := self projector value: v. (p x between: 0.0 and: self width asFloat) and: [ p y between: 0.0 and: self height asFloat ]]])
						asSortedCollection: [ :deeper :shallower | 
							((self zNumerizer value: shallower) ifNil: [ Float infinity ])
								<= ((self zNumerizer value: deeper) ifNil: [ Float infinity ]) ]).
					self renderer numVertices: visibleVertices size.
					visibleVertices do: [ :vertex | 
							(self renderer drawVertex: vertex borderColor: nil on: canvas)
								ifNotNil: [ :rect | 
									(rect containsPoint: handPosition)
										ifTrue: [ newHoverVertex := vertex ] ] ].
					hoverVertex := newHoverVertex.
					pathSelector value
						ifNotNil: [ 
							(canvas asAlphaBlendingCanvas: 0.8) fillColor: Color white.
							(paths at: pathSelector index)
								in: [ :path | 
									2 to: path size do: [ :index | 
										(path at: index - 1)
											edgesDo: [ :edge | 
												(edge vertex1 == (path at: index) or: [ edge vertex2 == (path at: index) ])
													ifTrue: [ self renderer drawEdge: edge color: Color black on: canvas ] ] ].
									path do: [ :vertex | self renderer drawVertex: vertex borderColor: nil on: canvas ] ] ]
						ifNil: [ 
							selectedVertices
								ifNotEmpty: [ 
									(canvas asAlphaBlendingCanvas: 0.8) fillColor: Color white.
									self
										fromAll: selectedVertices
										hops: hops * 2
										verticesDo: [ :vertex | self renderer drawVertex: vertex borderColor: nil on: canvas ]
										edgesDo: [ :edge | self renderer drawEdge: edge color: Color black on: canvas ] ] ].
					self
						selectedVerticesDo: [ :vertex | 
							vertex flushForms.
							self selectionRenderer drawVertex: vertex borderColor: Color red on: canvas.
							vertex flushForms ].
					self
						reactantsDo: [ :vertex | 
							vertex flushForms.
							self selectionRenderer drawVertex: vertex borderColor: Color blue on: canvas.
							vertex flushForms ].
					self
						productsDo: [ :vertex | 
							vertex flushForms.
							(self selectionRenderer drawVertex: vertex borderColor: Color blue on: canvas)
								ifNotNil: [ :rectangle | canvas frameRectangle: (rectangle insetBy: -3) width: 2 color: Color blue ].
							vertex flushForms ].
					hoverVertex
						ifNotNil: [ 
							hoverVertex flushForms.
							self selectionRenderer drawVertex: hoverVertex borderColor: Color black on: canvas.
							hoverVertex flushForms ].
					canvas flush ] ].
	aCanvas paintImage: form at: self position