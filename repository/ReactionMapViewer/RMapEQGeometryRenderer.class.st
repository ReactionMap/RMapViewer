Class {
	#name : #RMapEQGeometryRenderer,
	#superclass : #RMapGeometryRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMapEQGeometryRenderer >> formsFor: anRMapVertex [
	^ (anRMapVertex label notNil and: [ anRMapVertex label first = $E ])
		ifTrue: [ super formsFor: anRMapVertex ]
		ifFalse: [self plainLabelFormsFor: anRMapVertex]
]

{ #category : #accessing }
RMapEQGeometryRenderer >> name [
	^ 'EQ geometry'
]
