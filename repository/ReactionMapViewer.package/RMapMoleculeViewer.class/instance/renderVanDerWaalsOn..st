drawing
renderVanDerWaalsOn: aJunRenderingContext
	(molecule size > 64 and: [ false ])
		ifTrue: [ 
			molecule
				atomsDo: [ :atom | 
					| r |
					r := atom vanDerWaalsRadius.
					aJunRenderingContext color: atom color.
					atom
						triangles128Do: [ :v1 :v2 :v3 | 
							aJunRenderingContext
								displayPolygon: (Array with: v1 * r + atom position with: v2 * r + atom position with: v3 * r + atom position)
								normalVectors: (Array with: v1 unitVector with: v2 unitVector with: v3 unitVector) ] ] ]
		ifFalse: [ 
			molecule
				atomsDo: [ :atom | 
					| r |
					r := atom vanDerWaalsRadius.
					aJunRenderingContext color: atom color.
					atom
						triangles512Do: [ :v1 :v2 :v3 | 
							aJunRenderingContext
								displayPolygon: (Array with: v1 * r + atom position with: v2 * r + atom position with: v3 * r + atom position)
								normalVectors: (Array with: v1 unitVector with: v2 unitVector with: v3 unitVector) ] ] ]