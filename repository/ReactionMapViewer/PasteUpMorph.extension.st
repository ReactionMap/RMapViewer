Extension { #name : #PasteUpMorph }

{ #category : #'*ReactionMapViewer' }
PasteUpMorph >> handlesMouseDown: evt [
	^((Smalltalk includesKey: #RMapMorph) and: [ (Smalltalk at: #RMapMorph) isReleaseImage ]) not
]

{ #category : #'*ReactionMapViewer' }
PasteUpMorph >> windowEvent: anEvent [
	self windowEventHandler ifNotNil: [ ^ self windowEventHandler windowEvent: anEvent ].
	anEvent type == #windowClose
		ifTrue: [ 
			((Smalltalk includesKey: #RMapMorph) and: [ (Smalltalk at: #RMapMorph) isReleaseImage ])
				ifTrue: [ Smalltalk snapshot: false andQuit: true ]
				ifFalse: [ WorldState quitSession ] ]
]
