Class {
	#name : #RMapAdaptiveRenderer,
	#superclass : #RMapRenderer,
	#instVars : [
		'renderers',
		'selectedIndex'
	],
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #adding }
RMapAdaptiveRenderer >> add: anRMapRenderer maxNumVertices: anInteger [
	renderers add: anInteger -> anRMapRenderer.
	^ anRMapRenderer
]

{ #category : #drawing }
RMapAdaptiveRenderer >> drawEdge: anRMapEdge color: aColor on: aCanvas [
	^ self selectedRenderer drawEdge: anRMapEdge color: aColor on: aCanvas
]

{ #category : #drawing }
RMapAdaptiveRenderer >> drawVertex: anRMapVertex borderColor: aColor on: aCanvas [
	^ self selectedRenderer drawVertex: anRMapVertex borderColor: aColor on: aCanvas
]

{ #category : #accessing }
RMapAdaptiveRenderer >> formsFor: anRMapVertex [
	^ self selectedRenderer formsFor: anRMapVertex
]

{ #category : #'initialize-release' }
RMapAdaptiveRenderer >> initialize [
	super initialize.
	renderers := SortedCollection new.
	selectedIndex := 1
]

{ #category : #accessing }
RMapAdaptiveRenderer >> name [
	^ 'adaptive'
]

{ #category : #accessing }
RMapAdaptiveRenderer >> numVertices: anInteger [
	1 to: renderers size do: [  :i |
		(renderers at: i) key >= anInteger ifTrue: [selectedIndex := i. ^self]].
	selectedIndex := renderers size
]

{ #category : #accessing }
RMapAdaptiveRenderer >> selectedRenderer [
	^ (renderers at: selectedIndex) value
]

{ #category : #stepping }
RMapAdaptiveRenderer >> step [
	self selectedRenderer step
]
