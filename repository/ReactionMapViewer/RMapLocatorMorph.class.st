Class {
	#name : #RMapLocatorMorph,
	#superclass : #Morph,
	#instVars : [
		'rmapMorph',
		'isExpanded'
	],
	#category : 'ReactionMapViewer-Morphs'
}

{ #category : #'instance creation' }
RMapLocatorMorph class >> on: anRMapMorph [
	^ self new
		setRMapMorph: anRMapMorph;
		yourself
]

{ #category : #'event handling' }
RMapLocatorMorph >> click: anEvent [
	| x y |
	x := (anEvent position x - self left - 5.0) / (self width - 10.0).
	y := (self bottom - anEvent position y - 5) / (self height - 10.0).
	(rmapMorph respondsTo: #move:)
		ifTrue: [ rmapMorph viewOffset: x @ y ]
]

{ #category : #'submorphs-add/remove' }
RMapLocatorMorph >> delete [
	rmapMorph
		ifNotNil: [ 
			rmapMorph removeDependent: self.
			rmapMorph := nil ].
	super delete
]

{ #category : #drawing }
RMapLocatorMorph >> drawOn: aCanvas [
	aCanvas
		clipBy: self bounds
		during: [ :canvas | 
			canvas fillRectangle: self bounds color: Color white.
			rmapMorph
				verticesDo: [ :vertex | 
					(rmapMorph xNumerizer value: vertex)
						ifNotNil: [ :x | 
							(rmapMorph yNumerizer value: vertex)
								ifNotNil: [ :y | canvas fillRectangle: (x @ (1.0 - y) * (self extent - 10) + self position + 5 extent: 1 @ 1) color: Color black ] ] ].
			rmapMorph projector bounds
				in: [ :rect | 
					canvas
						frameRectangle:
							(((rect left @ (1.0 - rect bottom) extent: rect extent) scaleBy: self extent - 10) translateBy: self position + 5)
						color: Color red ] ]
]

{ #category : #'event handling' }
RMapLocatorMorph >> handlesKeyboard: event [
	^ true
]

{ #category : #'event handling' }
RMapLocatorMorph >> handlesMouseDown: event [
	^ true
]

{ #category : #'event handling' }
RMapLocatorMorph >> keyDown: event [
	^ self keyStroke: event
]

{ #category : #'event handling' }
RMapLocatorMorph >> keyStroke: event [
	event keyValue = 125
		ifTrue: [rmapMorph zoomIn].
	event keyValue = 126
		ifTrue: [rmapMorph zoomOut].
	^true
]

{ #category : #'event handling' }
RMapLocatorMorph >> keyboardFocusChange: event [
	super keyboardFocusChange: event.
	self focusChanged
]

{ #category : #'event handling' }
RMapLocatorMorph >> mouseDown: event [ 
	event hand waitForClicksOrDrag: self event: event
]

{ #category : #'event handling' }
RMapLocatorMorph >> mouseMove: anEvent [
	self left + 5 < anEvent position x
		ifTrue: [ 
			| x y |
			x := anEvent position x - self left - 5.0 / (self width - 10.0).
			y := self bottom - anEvent position y - 5 / (self height - 10.0).
			(rmapMorph respondsTo: #move:) ifTrue: [ rmapMorph viewOffset: x@y ]  ]
]

{ #category : #private }
RMapLocatorMorph >> setRMapMorph: anRMapMorph [
	rmapMorph := anRMapMorph.
	rmapMorph addDependent: self
]

{ #category : #'event handling' }
RMapLocatorMorph >> takesKeyboardFocus [ 
	^ true
]

{ #category : #updating }
RMapLocatorMorph >> update: aSymbol [
	(#(view visibleEnergyRangeMin visibleEnergyRangeMax) includes: aSymbol)
		ifTrue: [ self changed ]
]
