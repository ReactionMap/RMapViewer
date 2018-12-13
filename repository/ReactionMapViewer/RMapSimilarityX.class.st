Class {
	#name : #RMapSimilarityX,
	#superclass : #RMapSimilarityNumerizer,
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapSimilarityX >> value: anRMapVertex [
	^ sorter xFor: anRMapVertex
]
