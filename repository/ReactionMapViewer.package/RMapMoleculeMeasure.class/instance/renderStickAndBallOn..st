drawing
renderStickAndBallOn: aJunRenderingContext
	dragSource
		ifNil: [ super renderStickAndBallOn: aJunRenderingContext ]
		ifNotNil: [ 
			molecule
				atomsDo: [ :atom | 
					((dragSource ~~ atom and: [ self activeAtomsIncludes: atom ]) or: [ atom == dropTarget ])
						ifTrue: [ aJunRenderingContext solidPresentation ]
						ifFalse: [ aJunRenderingContext wireframePresentation ].
					atom renderOn: aJunRenderingContext ].
			aJunRenderingContext wireframePresentation.
			molecule bondsDo: [ :bond | bond renderOn: aJunRenderingContext ].
			aJunRenderingContext solidPresentation ]