Class {
	#name : #RMapSimilarityNumerizer,
	#superclass : #RMapVertexNumerizer,
	#instVars : [
		'sorter'
	],
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #'instance creation' }
RMapSimilarityNumerizer class >> on: anRMapMorph setter: aSymbol sorter: anRMapSimilaritySorter [
	^ (self on: anRMapMorph setter: aSymbol)
		setSorter: anRMapSimilaritySorter;
		yourself
]

{ #category : #accessing }
RMapSimilarityNumerizer >> name [
	^ 'Similarity'
]

{ #category : #private }
RMapSimilarityNumerizer >> setSorter: anRMapSimilaritySorter [
	sorter := anRMapSimilaritySorter
]

{ #category : #updating }
RMapSimilarityNumerizer >> update [
	sorter update
]

{ #category : #updating }
RMapSimilarityNumerizer >> updateSelection [
	sorter updateSelection
]
