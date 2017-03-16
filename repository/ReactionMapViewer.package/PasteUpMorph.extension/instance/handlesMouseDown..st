*ReactionMapViewer
handlesMouseDown: evt
	^((Smalltalk includesKey: #RMapMorph) and: [ (Smalltalk at: #RMapMorph) isReleaseImage ]) not