Class {
	#name : #RMapDepthRenderer,
	#superclass : #RMapPlainRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #drawing }
RMapDepthRenderer >> drawVertex: anRMapVertex borderColor: aColor on: aCanvas [
	^ (rmap isEffectiveVertex: anRMapVertex)
		ifTrue: [ 
			(rmap zNumerizer value: anRMapVertex)
				ifNotNil: [ :z | 
					(rmap projector value: anRMapVertex)
						ifNotNil: [ :p | 
							((p x between: 0.0 and: rmap width asFloat) and: [ p y between: 0.0 and: rmap height asFloat ])
								ifTrue: [ 
									(rmap projector value0: anRMapVertex)
										ifNotNil: [ :p0 | 
											aCanvas
												line: p
												to: p0
												width: 1
												color: (Color gray: 0.8) ] ] ] ].
			super drawVertex: anRMapVertex borderColor: aColor on: aCanvas ]
]

{ #category : #drawing }
RMapDepthRenderer >> name [
	^ 'depth'
]
