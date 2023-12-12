Class {
	#name : #RMapPluggableVertexListMorph,
	#superclass : #PluggableListMorph,
	#category : #'ReactionMapViewer-Morphs'
}

{ #category : #accessing }
RMapPluggableVertexListMorph >> borderStyleToUse [
	"Answer the borderStyle that should be used for the receiver."

	^ BorderStyle simple
		width: 1;
		baseColor: Color black
]

{ #category : #'initialize-release' }
RMapPluggableVertexListMorph >> initializeScrollBars [
	super initializeScrollBars.
	self hideHScrollBarIndefinitely: true
]

{ #category : #'initialize-release' }
RMapPluggableVertexListMorph >> initializeScrollbar [
	super initializeScrollbar.
	self hideHScrollBarIndefinitely: true
]

{ #category : #accessing }
RMapPluggableVertexListMorph >> listItemHeight [
	^ 64
]

{ #category : #accessing }
RMapPluggableVertexListMorph >> listMorphClass [
	^RMapLazyVertexListMorph
]
