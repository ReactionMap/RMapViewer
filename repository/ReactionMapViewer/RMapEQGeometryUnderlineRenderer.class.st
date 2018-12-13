Class {
	#name : #RMapEQGeometryUnderlineRenderer,
	#superclass : #RMapGeometryRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMapEQGeometryUnderlineRenderer >> edgePointsFor: anRMapVertex do: aBlock [
	anRMapVertex label first = $E
		ifTrue: [ self centerEdgePointsFor: anRMapVertex do: aBlock ]
		ifFalse: [ self leftAndRightEdgePointsFor: anRMapVertex do: aBlock ]
]

{ #category : #accessing }
RMapEQGeometryUnderlineRenderer >> formsFor: anRMapVertex [
	^ (anRMapVertex label notNil and: [ anRMapVertex label first = $E ])
		ifTrue: [ super formsFor: anRMapVertex ]
		ifFalse: [self underlineLabelFormsFor: anRMapVertex]
]

{ #category : #accessing }
RMapEQGeometryUnderlineRenderer >> name [
	^ 'EQ geometry, TS/DC underline'
]
