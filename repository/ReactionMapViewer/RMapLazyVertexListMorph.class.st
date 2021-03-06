Class {
	#name : #RMapLazyVertexListMorph,
	#superclass : #LazyListMorph,
	#category : 'ReactionMapViewer-Morphs'
}

{ #category : #'list management' }
RMapLazyVertexListMorph >> adjustHeight [
	"private.  Adjust our height to match the length of the underlying list"
	self height: (listItems size max: 1) * 64

]

{ #category : #'list management' }
RMapLazyVertexListMorph >> rowAtLocation: aPoint [
	"return the number of the row at aPoint"

	| y |
	y := aPoint y.
	y < self top
		ifTrue: [ ^ 1 ].
	^ (y - self top) // 64 + 1 min: listItems size max: 0
]
