Class {
	#name : #RMapDotRenderer,
	#superclass : #RMapRenderer,
	#classVars : [
		'BlackForm',
		'GrayForm'
	],
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMapDotRenderer >> blackForm [
	^ BlackForm
		ifNil: [ 
			| form |
			form := Form extent: 3 @ 3 depth: 32.
			form getCanvas in: [ :canvas | canvas fillColor: Color black ].
			BlackForm := form ]
]

{ #category : #drawing }
RMapDotRenderer >> drawEdge: anRMapEdge color: aColor on: aCanvas [
]

{ #category : #accessing }
RMapDotRenderer >> formFor: anRMapVertex [
	^ anRMapVertex isEQ
		ifTrue: [ self blackForm ]
		ifFalse: [ self grayForm ]
]

{ #category : #accessing }
RMapDotRenderer >> grayForm [
	^ GrayForm
		ifNil: [ 
			| form |
			form := Form extent: 3 @ 3 depth: 32.
			form getCanvas in: [ :canvas | canvas fillColor: Color gray ].
			GrayForm := form ]
]

{ #category : #accessing }
RMapDotRenderer >> name [
	^ 'dot'
]
