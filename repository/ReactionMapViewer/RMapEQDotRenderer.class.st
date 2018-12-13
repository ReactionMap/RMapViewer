Class {
	#name : #RMapEQDotRenderer,
	#superclass : #RMapDotRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMapEQDotRenderer >> formFor: anRMapVertex [
	^ anRMapVertex isEQ
		ifTrue: [ self blackForm ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
RMapEQDotRenderer >> name [
	^ 'dot(EQ)'
]
