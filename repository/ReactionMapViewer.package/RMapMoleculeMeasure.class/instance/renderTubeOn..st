drawing
renderTubeOn: aJunRenderingContext
	dragSource ifNil: [ super renderTubeOn: aJunRenderingContext ].
	aJunRenderingContext wireframePresentation.
	molecule bondsDo: [ :bond | bond renderTubeOn: aJunRenderingContext ].
	molecule
		atomsDo: [ :atom | 
			| r |
			r := 0.15.
			aJunRenderingContext color: atom color.
			((dragSource ~~ atom and: [ self activeAtomsIncludes: atom ]) or: [ atom == dropTarget ])
				ifTrue: [ aJunRenderingContext solidPresentation ]
				ifFalse: [ aJunRenderingContext wireframePresentation ].
			atom
				triangles128Do: [ :v1 :v2 :v3 | 
					aJunRenderingContext
						displayPolygon: (Array with: v1 * r + atom position with: v2 * r + atom position with: v3 * r + atom position)
						normalVectors: (Array with: v1 unitVector with: v2 unitVector with: v3 unitVector) ] ].
	aJunRenderingContext solidPresentation