Class {
	#name : #RMapVertexListItem,
	#superclass : #Object,
	#instVars : [
		'vertex'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'instance creation' }
RMapVertexListItem class >> on: anRMapVertex [
	^ self new
		vertex: anRMapVertex;
		yourself
]

{ #category : #'list icon support' }
RMapVertexListItem >> heightToDisplayInList: aListMorph [
	^ 64
]

{ #category : #'list icon support' }
RMapVertexListItem >> listIconSize [
	^ 64
]

{ #category : #'list icon support' }
RMapVertexListItem >> listRenderOn: aCanvas atRow: row bounds: aRectangle color: aColor backgroundColor: backgroundColor from: aListMorph [
	"aCanvas fillRectangle: aRectangle color: backgroundColor."
	"aCanvas paintImage: self form at: aRectangle topLeft"
	aCanvas drawString: vertex label at: 2 @ ((64 - TextStyle defaultFont height) / 2.0) + aRectangle topLeft.
	aCanvas paintImage: (vertex asFormExtent: self listIconSize @ self listIconSize) at: aRectangle topLeft + (70@0).
]

{ #category : #accessing }
RMapVertexListItem >> vertex [
	^ vertex
]

{ #category : #accessing }
RMapVertexListItem >> vertex: anRMapVertex [
	vertex := anRMapVertex
]

{ #category : #'list icon support' }
RMapVertexListItem >> widthToDisplayInList: aListMorph [
	^ 150
]
