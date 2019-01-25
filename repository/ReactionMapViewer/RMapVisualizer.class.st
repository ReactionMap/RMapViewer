Class {
	#name : #RMapVisualizer,
	#superclass : #Object,
	#category : #'ReactionMapViewer-Visualizers'
}

{ #category : #drawing }
RMapVisualizer >> draw: anRMapMorph on: aCanvas [
	| font c hoverVertex |
	font := TextStyle default defaultFont.
	c := anRMapMorph selectedPath
		ifNil: [ Color black ]
		ifNotNil: [ :path | Color gray: 0.7 ].
	hoverVertex := anRMapMorph hoverVertex.
	anRMapMorph
		effectiveEdgesDo: [ :edge | 
			aCanvas
				line: edge vertex1 layoutPosition
				to: edge vertex2 layoutPosition
				color: c ].
	anRMapMorph selectedPath
		ifNotNil: [ :path | 
			1 to: path size - 1 do: [ :i | 
				aCanvas
					line: (path at: i) layoutPosition
					to: (path at: i + 1) layoutPosition
					width: 2
					color: Color black ].
			path first ~~ hoverVertex
				ifTrue: [ | vertex |
					vertex := path first.
					aCanvas
						paintImage: vertex model64Form
							at: vertex layoutPosition - (32 @ 32);
						drawString: vertex label
							at:
							vertex layoutPosition
								- (((font widthOfString: vertex label) // 2) @ (font height - 32)) ].
			2 to: path size - 1 do: [ :i | 
				| vertex |
				vertex := path at: i.
				vertex ~~ hoverVertex
					ifTrue: [ aCanvas
							paintImage: vertex model64Form
								at: vertex layoutPosition - (32 @ 32);
							drawString: vertex label
								at:
								vertex layoutPosition
									- (((font widthOfString: vertex label) // 2) @ (font height - 32)) ] ].
			path last ~~ hoverVertex
				ifTrue: [ | vertex |
					vertex := path last.
					aCanvas
						paintImage: vertex model64Form
							at: vertex layoutPosition - (32 @ 32);
						drawString: vertex label
							at:
							vertex layoutPosition
								- (((font widthOfString: vertex label) // 2) @ (font height - 32)) ] ]
		ifNil: [ anRMapMorph
				effectiveVerticesDo: [ :vertex | 
					(vertex ~~ hoverVertex and: [ (anRMapMorph hasMarked: vertex) not ])
						ifTrue: [ self drawVertex: vertex on: aCanvas ] ].
			anRMapMorph
				reactantsDo: [ :vertex | 
					vertex ~~ hoverVertex
						ifTrue: [ aCanvas
								paintImage: vertex model64Form
									at: vertex layoutPosition - (32 @ 32);
								drawString: vertex label
									at:
									vertex layoutPosition
										- (((font widthOfString: vertex label) // 2) @ (font height - 32));
								frameRectangle: (vertex layoutPosition - (32 @ 32) extent: 64 @ 64)
									width: 2
									color: Color blue ] ].
			anRMapMorph
				productsDo: [ :vertex | 
					vertex ~~ hoverVertex
						ifTrue: [ aCanvas
								paintImage: vertex model64Form
									at: vertex layoutPosition - (32 @ 32);
								drawString: vertex label
									at:
									vertex layoutPosition
										- (((font widthOfString: vertex label) // 2) @ (font height - 32));
								frameRectangle: (vertex layoutPosition - (32 @ 32) extent: 64 @ 64)
									width: 1
									color: Color blue;
								frameRectangle: (vertex layoutPosition - (35 @ 35) extent: 70 @ 70)
									width: 1
									color: Color blue ] ].
			anRMapMorph
				selectedVerticesDo: [ :vertex | 
					vertex ~~ hoverVertex
						ifTrue: [ aCanvas
								paintImage: vertex model64Form
									at: vertex layoutPosition - (32 @ 32);
								drawString: vertex label
									at:
									vertex layoutPosition
										- (((font widthOfString: vertex label) // 2) @ (font height - 32));
								frameRectangle: (vertex layoutPosition - (32 @ 32) extent: 64 @ 64)
									width: 1
									color: Color red ] ] ].
	anRMapMorph hoverVertex
		ifNotNil: [ :vertex | 
			| form |
			form := anRMapMorph showInfoOnHover
				ifTrue: [ vertex infoForm ]
				ifFalse: [ vertex model64Form ].
			aCanvas
				fillRectangle: (0 @ 0 extent: anRMapMorph extent)
					color: (Color white alpha: 0.7);
				paintImage: form at: vertex layoutPosition - (form extent // 2).
			anRMapMorph showInfoOnHover
				ifFalse: [ aCanvas
						drawString: vertex label
							at:
							vertex layoutPosition
								- (((font widthOfString: vertex label) // 2) @ (font height - 32));
						frameRectangle: (vertex layoutPosition - (35 @ 35) extent: 70 @ 70)
							width: 3
							color: Color black ] ]
]

{ #category : #drawing }
RMapVisualizer >> drawVertex: anRMapMorph on: aCanvas [
	^ self subclassResponsibility
]
