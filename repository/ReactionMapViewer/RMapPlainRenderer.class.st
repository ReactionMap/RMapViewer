Class {
	#name : #RMapPlainRenderer,
	#superclass : #RMapRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMapPlainRenderer >> formsFor: anRMapVertex [
	^self plainLabelFormsFor: anRMapVertex
]

{ #category : #accessing }
RMapPlainRenderer >> name [
	^'plain'
]
