Class {
	#name : #RMapVertex,
	#superclass : #Object,
	#instVars : [
		'edges',
		'json',
		'position',
		'energy',
		'baselineEnergy',
		'bonds',
		'forms'
	],
	#classVars : [
		'AtomColors'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'instance creation' }
RMapVertex class >> fromJson: aDictionary [
	| label |
	label := (aDictionary at: 'label' ifAbsent: [ 'E' ]) first.
	label = $D
		ifTrue: [ 
			^ RMapDCVertex new
				setJson: aDictionary;
				yourself ].
	label = $T
		ifTrue: [ 
			^ RMapTSVertex new
				setJson: aDictionary;
				yourself ].
	^ RMapEQVertex new
		setJson: aDictionary;
		yourself
]

{ #category : #accessing }
RMapVertex >> addEdge: anRMapEdge [
	edges add: anRMapEdge
]

{ #category : #converting }
RMapVertex >> as2dJunMoleculeGeometry [
	| molecule |
	molecule := RMapMolecule new.
	self geometry2dDo: [ :atom :x :y :z | molecule addAtom: (JunAtom symbol: atom at: x ,, y ,, z) ].
	bonds do: [ :triple | (molecule addBondBetween: triple first and: triple second) order: triple third ].
	^ molecule
]

{ #category : #converting }
RMapVertex >> asFormExtent: aPoint [
	| molecule box center form projection rc |
	molecule := RMapMolecule new.
	self geometry2dDo: [:atom :x :y :z |
		molecule add: (JunAtom symbol: atom at: (Jun3dPoint x: x y: y z: z)) ].
	molecule autoBonds.
	box := molecule boundingBox.
	center := box center.
	form := Form extent: aPoint depth: 32.
	projection := JunParallelProjection
		eyePoint: 0,, 0,, (box depth * 2) + center
		sightPoint: center
		upVector: 0 ,, 1 ,, 0
		height: (box width max: box height)
		near: 0.1
		far: box depth * 10.
	[ 
	rc := [ form renderingContext ]
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
	^ form
]

{ #category : #converting }
RMapVertex >> asListItem [
	^ RMapVertexListItem on: self
]

{ #category : #converting }
RMapVertex >> asMolecule [
	| molecule |
	molecule := RMapMolecule new.
	self geometryDo: [ :atom :x :y :z | molecule addAtom: (JunAtom symbol: atom at: x ,, y ,, z) ].
	bonds do: [ :triple | (molecule addBondBetween: triple first and: triple second) order: triple third ].
	molecule energy: self energy.
	molecule label: self label.
	^ molecule
]

{ #category : #accessing }
RMapVertex >> at: aString [
	^ json at: aString ifAbsent: [  ]
]

{ #category : #accessing }
RMapVertex >> at: aString ifAbsent: aBlock [
	^ json at: aString ifAbsent: aBlock
]

{ #category : #accessing }
RMapVertex >> at: aString ifAbsentPut: aBlock [
	^ json at: aString ifAbsentPut: aBlock
]

{ #category : #accessing }
RMapVertex >> at: aString ifPresent: aBlock [
	^ json at: aString ifPresent: aBlock
]

{ #category : #accessing }
RMapVertex >> at: aString ifPresent: aBlock ifAbsent: absentBlock [
	^ json at: aString ifPresent: aBlock ifAbsent: absentBlock
]

{ #category : #accessing }
RMapVertex >> atomColorAt: anAtomName [
	^AtomColors at: anAtomName ifAbsent: [ Color black ]
]

{ #category : #'accessing-energy' }
RMapVertex >> baselineEnergy: aNumber [
	baselineEnergy := aNumber asFloat
]

{ #category : #accessing }
RMapVertex >> bonds [
	^ bonds
]

{ #category : #enumerating }
RMapVertex >> bondsDo: aBlock [
	bonds do: [ :a1a2type | aBlock valueWithArguments: a1a2type ]
]

{ #category : #accessing }
RMapVertex >> canost [
	^ self at: 'canost' ifAbsent: [ 'N/A' ]
]

{ #category : #private }
RMapVertex >> centroidX [
	| cx  |
	cx := 0.0.
	self
		geometryDo: [ :atom :x :y :z | 
			cx := cx + x].
	^ cx / self geometry size asFloat
]

{ #category : #private }
RMapVertex >> centroidY [
	| cy  |
	cy := 0.0.
	self
		geometryDo: [ :atom :x :y :z | 
			cy := cy + y].
	^ cy / self geometry size asFloat
]

{ #category : #private }
RMapVertex >> centroidZ [
	| cz  |
	cz := 0.0.
	self
		geometryDo: [ :atom :x :y :z | 
			cz := cz + z].
	^ cz / self geometry size asFloat
]

{ #category : #enumerating }
RMapVertex >> continue: frame from: vertex framesDo: aBlock [
	| transformation |
	transformation := frame transformationBlockWith: (self firstFrameFrom: vertex).
	self
		from: vertex
		framesDo: [ :f | 
			aBlock
				value:
					(Array new writeStream
						in: [ :transformedAtoms | 
							f atomsDo: [ :atom :point | transformedAtoms nextPut: atom -> (transformation value: point) ].
							RMapXYZFrame from: transformedAtoms contents ]) ]
]

{ #category : #enumerating }
RMapVertex >> continue: frame from: vertex1 to: vertex2 framesDo: aBlock [
	| transformation |
	transformation := frame transformationBlockWith: (self firstFrameFrom: vertex1 to: vertex2).
	self
		from: vertex1
		to: vertex2
		framesDo: [ :f | 
			aBlock
				value:
					(Array new writeStream
						in: [ :transformedAtoms | 
							f atomsDo: [ :atom :point | transformedAtoms nextPut: atom -> (transformation value: point) ].
							RMapXYZFrame from: transformedAtoms contents ]) ]
]

{ #category : #enumerating }
RMapVertex >> continue: frame to: vertex framesDo: aBlock [
	| transformation |
	transformation := frame transformationBlockWith: (self firstFrameTo: vertex).
	self
		to: vertex
		framesDo: [ :f | 
			aBlock
				value:
					(Array new writeStream
						in: [ :transformedAtoms | 
							f atomsDo: [ :atom :point | transformedAtoms nextPut: atom -> (transformation value: point) ].
							RMapXYZFrame from: transformedAtoms contents ]) ]
]

{ #category : #enumerating }
RMapVertex >> edgesDo: aBlock [
	edges do: aBlock
]

{ #category : #'accessing-energy' }
RMapVertex >> energy [
	^ energy
]

{ #category : #private }
RMapVertex >> firstFrameFrom: vertex [
	self from: vertex framesDo: [ :f | ^ f ].
	^ RMapXYZFrame fromGeometry: self geometry
]

{ #category : #private }
RMapVertex >> firstFrameFrom: vertex1 to: vertex2 [
	self from: vertex1 to: vertex2 framesDo: [ :f | ^ f ].
	^ RMapXYZFrame fromGeometry: self geometry
]

{ #category : #private }
RMapVertex >> firstFrameTo: vertex [
	self to: vertex framesDo: [ :f | ^ f ].
	^ RMapXYZFrame fromGeometry: self geometry
]

{ #category : #accessing }
RMapVertex >> flushForms [
	forms := nil
]

{ #category : #private }
RMapVertex >> forms [
	^ forms
]

{ #category : #accessing }
RMapVertex >> formsIfAbsentPut: aBlock [
	^ forms ifNil: [ forms := aBlock cull: self ]
]

{ #category : #accessing }
RMapVertex >> fullShapeSignature [
	^ self asMolecule fullShapeSignature
]

{ #category : #accessing }
RMapVertex >> geometry [
	^ json at: 'geometry' ifAbsentPut: [ Array new ]
]

{ #category : #private }
RMapVertex >> geometry2dDo: aBlock [
	| a f f1 f2 f3 |
	a := DhbMatrix rows: (self geometryMatrix).
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
	self
		geometryDo: [ :atom :x :y :z | 
			| v |
			v := DhbVector with: x with: y with: z.
			aBlock
				value: atom
				value: f1 * v
				value: f2 * v
				value: f3 * v ]
]

{ #category : #enumerating }
RMapVertex >> geometryDo: aBlock [
	(json at: 'geometry') do: [ :axyz | aBlock valueWithArguments: axyz ]
]

{ #category : #private }
RMapVertex >> geometryMatrix [
	| matrix cx cy cz |
	matrix := (Array new: self geometry size) writeStream.
	cx := self centroidX.
	cy := self centroidY.
	cz := self centroidZ.
	self geometryDo: [ :atom :x :y :z | matrix nextPut: (Array with: x - cx with: y - cy with: z - cz) ].
	^ matrix contents
]

{ #category : #'accessing-energy' }
RMapVertex >> hartree [
	^ self energy
]

{ #category : #accessing }
RMapVertex >> inchi [
	^ self at: 'inchi' ifAbsent: [ 'N/A' ]
]

{ #category : #'initialize-release' }
RMapVertex >> initialize [
	super initialize.
	baselineEnergy := 0.0.
	edges := OrderedCollection new.
	json := Dictionary new
]

{ #category : #testing }
RMapVertex >> isDC [
	^ false
]

{ #category : #testing }
RMapVertex >> isEQ [
	^ false
]

{ #category : #testing }
RMapVertex >> isTS [
	^ false
]

{ #category : #private }
RMapVertex >> json [
	^ json
]

{ #category : #'accessing-energy' }
RMapVertex >> kJpermol [
	^ self energy * 2625.49962
]

{ #category : #'accessing-energy' }
RMapVertex >> kJpermolAboveBaseline [
	^ (self energy - baselineEnergy) * 2625.49962
]

{ #category : #'accessing-energy' }
RMapVertex >> kJpermolAboveBaselineString [
	^ (self kJpermolAboveBaseline printShowingDecimalPlaces: 1), ' kJ/mol'
]

{ #category : #'accessing-energy' }
RMapVertex >> kcalpermol [
	^ self energy * 627.509469
]

{ #category : #accessing }
RMapVertex >> label [
	^ json at: 'label' ifAbsentPut: [ String new ]
]

{ #category : #accessing }
RMapVertex >> neighbors [
	^ edges
		collect: [ :edge | 
			edge vertex1 == self
				ifTrue: [ edge vertex2 ]
				ifFalse: [ edge vertex1 ] ]
]

{ #category : #enumerating }
RMapVertex >> neighborsDo: aBlock [
	edges
		do: [ :edge | 
			edge vertex1 == self
				ifTrue: [ aBlock value: edge vertex2 ]
				ifFalse: [ aBlock value: edge vertex1 ] ]
]

{ #category : #accessing }
RMapVertex >> numEdges [
	^ edges size
]

{ #category : #utilities }
RMapVertex >> openInfo [
	| font lines extent |
	font := TextStyle default defaultFont.
	lines := {('label: ' , self label).
	('energy: ' , self kJpermolAboveBaselineString).
	('smiles: ' , self smiles).
	('inchi: ' , self inchi).
	('canost: ' , self canost)}.
	extent := ((lines inject: 0 into: [ :max :each | max max: (font widthOfString: each) ]) + 4)
		@ (lines size * font height + 4).
	(Text
		initialFont: font
		stringOrText:
			(String streamContents: [ :stream | lines do: [ :line | stream nextPutAll: line ] separatedBy: [ stream cr ] ]))
		asMorph
		extent: extent;
		backgroundColor: Color white;
		openInWindowLabeled: self label;
		color: Color black
]

{ #category : #utilities }
RMapVertex >> openJmol [
	(RMapMoleculeViewer on: self asMolecule)
		extent: 300 @ 300;
		openInWindowLabeled: self label
]

{ #category : #utilities }
RMapVertex >> openMeasureViewer [
	(RMapMoleculeMeasure on: self asMolecule)
		extent: 300 @ 300;
		openInWindowLabeled: self label
]

{ #category : #accessing }
RMapVertex >> position [
	^ position
]

{ #category : #printing }
RMapVertex >> printOn: aStream [
	aStream nextPut: $<.
	json at: 'label' ifPresent: [:label | aStream nextPutAll: label ].
	aStream nextPut: $>
]

{ #category : #private }
RMapVertex >> setJson: aDictionary [
	json := aDictionary.
	(aDictionary at: 'position' ifAbsent: [Array with: 0 with: 0]) in:  [ :positionArray | position := positionArray first @ positionArray second ].
	(aDictionary at: 'bonds' ifAbsent: [Array new]) in: [ :bondsArray | bonds := bondsArray collect: [  :triple | Array with: triple first + 1 with: triple second + 1 with: triple third ] ].
	(aDictionary at: 'energy' ifAbsent: [0.0]) in: [:e | energy := e]
]

{ #category : #accessing }
RMapVertex >> smiles [
	^ self at: 'smiles' ifAbsent: [ 'N/A' ]
]

{ #category : #private }
RMapVertex >> sortEdgesByEnergy [
	edges := (((edges
		collect: [ :e | 
			e
				->
					(e vertex1 == self
						ifTrue: [ e vertex2 ]
						ifFalse: [ e vertex1 ]) energy ]) asSortedCollection: [ :less :more | less value <= more value ])
		collect: [ :assoc | assoc key ]) asOrderedCollection
]

{ #category : #accessing }
RMapVertex >> xyz [
	^ Array new writeStream
		in: [ :stream | 
			stream nextPutAll: self geometry size printString.
			stream cr.
			stream cr.
			self geometry
				in: [ :geoms | 
					geoms
						do: [ :geom | 
							stream nextPutAll: geom first.
							stream space.
							stream nextPutAll: geom second printString.
							stream space.
							stream nextPutAll: geom third printString.
							stream space.
							stream nextPutAll: geom fourth printString.
							stream cr ] ].
			stream contents ]
]

{ #category : #accessing }
RMapVertex >> xyzString [
	^ String new writeStream
		in: [ :stream | 
			stream nextPutAll: self geometry size printString.
			stream cr.
			stream cr.
			self geometry
				in: [ :geoms | 
					geoms
						do: [ :geom | 
							stream nextPutAll: geom first.
							stream space.
							stream nextPutAll: geom second printString.
							stream space.
							stream nextPutAll: geom third printString.
							stream space.
							stream nextPutAll: geom fourth printString.
							stream cr ] ].
			stream contents ]
]
