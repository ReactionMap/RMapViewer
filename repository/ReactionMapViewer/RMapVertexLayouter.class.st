Class {
	#name : #RMapVertexLayouter,
	#superclass : #Object,
	#instVars : [
		'rmap',
		'viewOffsetX',
		'viewOffsetY',
		'scaleX',
		'scaleY',
		'offsetX',
		'offsetY'
	],
	#category : #'ReactionMapViewer-Layouters'
}

{ #category : #'instance creation' }
RMapVertexLayouter class >> on: anRMapMorph [
	^ self new setRMap: anRMapMorph
]

{ #category : #drawing }
RMapVertexLayouter >> drawLegendsOn: aCanvas [
	
]

{ #category : #'initialize-release' }
RMapVertexLayouter >> initializeWithRMap [
]

{ #category : #accessing }
RMapVertexLayouter >> normalizedPositionFor: anRMapVertex [
	^ self subclassResponsibility
]

{ #category : #updating }
RMapVertexLayouter >> normalizedPositionToPosition: aPoint [
	^ ((aPoint x - viewOffsetX) * scaleX + offsetX)
		@ ((aPoint y - viewOffsetY) * scaleY + offsetY)
]

{ #category : #private }
RMapVertexLayouter >> setRMap: anRMapMorph [
	rmap := anRMapMorph.
	self initializeWithRMap
]

{ #category : #updating }
RMapVertexLayouter >> update [
	| w h scale |
	w := rmap width asFloat.
	h := rmap height asFloat.
	scale := w max: h.
	viewOffsetX := rmap viewOffset x.
	viewOffsetY := rmap viewOffset y.
	scaleX := rmap viewScale * scale.
	scaleY := rmap viewScale negated * scale.
	offsetX := w // 2.
	offsetY := h // 2.
	rmap
		verticesDo: [ :vertex | 
			| p |
			p := self normalizedPositionFor: vertex.
			vertex normalizedLayoutPosition: p.
			vertex
				layoutPosition:
					((p x - viewOffsetX) * scaleX + offsetX)
						@ ((p y - viewOffsetY) * scaleY + offsetY) ]
]
