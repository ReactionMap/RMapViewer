Class {
	#name : #RMapLabelVisualizer,
	#superclass : #RMapVisualizer,
	#category : #'ReactionMapViewer-Visualizers'
}

{ #category : #drawing }
RMapLabelVisualizer >> drawVertex: anRMapVertex on: aCanvas [
	aCanvas
		paintImage: anRMapVertex labelForm
		at: anRMapVertex layoutPosition - (anRMapVertex labelForm extent // 2)
]
