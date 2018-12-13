Class {
	#name : #RMap3dGeometryRenderer,
	#superclass : #RMapRenderer,
	#instVars : [
		'form',
		'renderingContext'
	],
	#category : #'ReactionMapViewer-Renderers'
}

{ #category : #private }
RMap3dGeometryRenderer >> centroidX: anRMapVertex [
	| cx  |
	cx := 0.0.
	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			cx := cx + x].
	^ cx / anRMapVertex geometry size asFloat
]

{ #category : #private }
RMap3dGeometryRenderer >> centroidY: anRMapVertex [
	| cy  |
	cy := 0.0.

	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			cy := cy + y].
	^ cy / anRMapVertex geometry size asFloat
]

{ #category : #private }
RMap3dGeometryRenderer >> centroidZ: anRMapVertex [
	| cz  |
	cz := 0.0.
	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			cz := cz + z].
	^ cz / anRMapVertex geometry size asFloat
]

{ #category : #accessing }
RMap3dGeometryRenderer >> extent [
	^ self subclassResponsibility
]

{ #category : #private }
RMap3dGeometryRenderer >> flushForm [
	form := nil
]

{ #category : #private }
RMap3dGeometryRenderer >> formExtent: extent [
	(form isNil or: [ form extent ~= extent ])
		ifTrue: [ form := Form extent: extent depth: 32 ].
	^ form
]

{ #category : #accessing }
RMap3dGeometryRenderer >> formsFor: anRMapVertex [
	^ self formsFor: anRMapVertex extent: self extent
]

{ #category : #accessing }
RMap3dGeometryRenderer >> formsFor: anRMapVertex extent: extent [
	| molecule box center projection rc |
	molecule := RMapMolecule new.
	self
		geometry2d: anRMapVertex
		do: [ :atom :x :y :z | molecule add: (JunAtom symbol: atom at: (Jun3dPoint x: x y: y z: z)) ].
	molecule autoBonds.
	box := molecule boundingBox.
	center := box center.
	self formExtent: extent.
	projection := JunParallelProjection
		eyePoint: (0 ,, 0 ,, (box depth * 2)) + center
		sightPoint: center
		upVector: 0 ,, 1 ,, 0
		height: (box width max: box height)
		near: 0.1
		far: box depth * 10.
	[ rc := [ form renderingContext ]
		on: Error
		do: [ :ex | nil ].
	rc isNil ] whileTrue: [ Processor yield ].
	rc enableCullface.
	rc backgroundColor: Color transparent.
	rc projection: projection.
	rc clear.
	rc ambientLight: Color gray.
	rc lightIndex: 0 parallel: projection eyePoint negated color: Color gray.
	molecule renderOn: rc.
	rc flush.
	^ Array with: (form copy: (0 @ 0 extent: form extent))
]

{ #category : #private }
RMap3dGeometryRenderer >> geometry2d: anRMapVertex do: aBlock [
	| a f f1 f2 f3 |
	a := DhbMatrix rows: (self geometryMatrix: anRMapVertex).
	f := (a transpose * a) orthogonalize.
	f1 := f numberOfColumns >= 1
		ifTrue: [ f columnAt: 1 ]
		ifFalse: [ DhbVector with: 0.0 with: 0.0 with: 0.0 ].
	f2 := f numberOfColumns >= 2
		ifTrue: [ f columnAt: 2 ]
		ifFalse: [ DhbVector with: 0.0 with: 0.0 with: 0.0 ].
	f3 := f numberOfColumns >= 3
		ifTrue: [ f columnAt: 3 ]
		ifFalse: [ DhbVector with: 0.0 with: 0.0 with: 0.0 ].
	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			| v |
			v := DhbVector with: x with: y with: z.
			aBlock
				value: atom
				value: f1 * v
				value: f2 * v
				value: f3 * v ]
]

{ #category : #private }
RMap3dGeometryRenderer >> geometryMatrix: anRMapVertex [
	| matrix cx cy cz |
	matrix := (Array new: anRMapVertex geometry size) writeStream.
	cx := self centroidX: anRMapVertex.
	cy := self centroidY: anRMapVertex.
	cz := self centroidZ: anRMapVertex.
	anRMapVertex geometryDo: [ :atom :x :y :z | matrix nextPut: (Array with: x - cx with: y - cy with: z - cz) ].
	^ matrix contents
]
