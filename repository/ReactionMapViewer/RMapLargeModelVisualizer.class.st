Class {
	#name : #RMapLargeModelVisualizer,
	#superclass : #RMapVisualizer,
	#category : #'ReactionMapViewer-Visualizers'
}

{ #category : #drawing }
RMapLargeModelVisualizer >> drawVertex: anRMapVertex on: aCanvas [
	aCanvas
		paintImage: anRMapVertex model64Form
		at: anRMapVertex layoutPosition - (anRMapVertex model64Form extent // 2)
]
