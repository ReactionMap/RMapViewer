Class {
	#name : #RMapSimilarityY,
	#superclass : #RMapSimilarityNumerizer,
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapSimilarityY >> value: anRMapVertex [
	^ sorter yFor: anRMapVertex
]
