Class {
	#name : #RMapSmallModelVisualizer,
	#superclass : #RMapVisualizer,
	#category : #'ReactionMapViewer-Visualizers'
}

{ #category : #drawing }
RMapSmallModelVisualizer >> drawVertex: anRMapVertex on: aCanvas [
	aCanvas
		paintImage: anRMapVertex model32Form
		at: anRMapVertex layoutPosition - (anRMapVertex model32Form extent // 2)
]
