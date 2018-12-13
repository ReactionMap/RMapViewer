Class {
	#name : #RMapLabelMorph,
	#superclass : #StringMorph,
	#category : 'ReactionMapViewer-Morphs'
}

{ #category : #drawing }
RMapLabelMorph >> drawOn: aCanvas [
	| f |
	f := self fontToUse.
	aCanvas
		drawString: contents
		in: (Rectangle center: self center extent: (f widthOfString: contents) @ f height)
		font: f
		color: color
]
