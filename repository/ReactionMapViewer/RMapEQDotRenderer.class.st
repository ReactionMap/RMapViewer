Class {
	#name : #RMapEQDotRenderer,
	#superclass : #RMapDotRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMapEQDotRenderer >> formsFor: anRMapVertex [
	^ anRMapVertex isEQ
		ifTrue: [ Array with: self blackForm ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
RMapEQDotRenderer >> name [
	^ 'dot(EQ)'
]
