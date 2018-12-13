Class {
	#name : #RMapAlphaRenderer,
	#superclass : #RMapPlainRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #drawing }
RMapAlphaRenderer >> drawEdge: anRMapEdge color: aColor on: aCanvas [
	| z1 z2 |
	z1 := rmap zNumerizer value: anRMapEdge vertex1.
	z2 := rmap zNumerizer value: anRMapEdge vertex2.
	z1 ifNil: [ z1 := z2 ].
	z2 ifNil: [ z2 := z1 ].
	z1 ifNil: [ ^ self ].
	super drawEdge: anRMapEdge color: aColor on: (aCanvas asAlphaBlendingCanvas: ((2.0 - z1 - z2) * 0.4 + 0.2 min: 1.0 max: 0.0))
]

{ #category : #drawing }
RMapAlphaRenderer >> drawVertex: anRMapVertex borderColor: aColor on: aCanvas [
	^ (rmap isEffectiveVertex: anRMapVertex)
		ifTrue: [ 
			(rmap zNumerizer value: anRMapVertex)
				ifNotNil: [ :z | 
					(rmap projector value: anRMapVertex)
						ifNotNil: [ :p | 
							((p x between: 0.0 and: rmap width asFloat) and: [ p y between: 0.0 and: rmap height asFloat ])
								ifTrue: [ 
									| form rect |
									form := self formFor: anRMapVertex.
									rect := p - (form extent / 2.0 + 2) extent: form extent + 4.
									aColor
										ifNotNil: [ 
											aCanvas
												frameAndFillRectangle: rect
												fillColor: Color white
												borderWidth: 2
												borderColor: aColor ]
										ifNil: [ aCanvas fillRectangle: (p - (form extent / 2.0) extent: form extent) color: Color white ].
									(aCanvas asAlphaBlendingCanvas: ((1.0 - z) * 0.8 + 0.2 min: 1.0 max: 0.0))
										in: [ :canvas | canvas drawImage: form at: p - (form extent / 2.0) ].
									rect ] ] ] ]
]

{ #category : #accessing }
RMapAlphaRenderer >> name [
	^ 'fade'
]