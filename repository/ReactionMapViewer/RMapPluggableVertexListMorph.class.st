Class {
	#name : #RMapPluggableVertexListMorph,
	#superclass : #PluggableListMorph,
	#category : 'ReactionMapViewer-Morphs'
}

{ #category : #accessing }
RMapPluggableVertexListMorph >> listItemHeight [
	^ 64
]

{ #category : #accessing }
RMapPluggableVertexListMorph >> listMorphClass [
	^RMapLazyVertexListMorph
]
