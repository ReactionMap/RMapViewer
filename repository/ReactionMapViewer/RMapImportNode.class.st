Class {
	#name : #RMapImportNode,
	#superclass : #Object,
	#instVars : [
		'label',
		'position',
		'energy',
		'geometry',
		'bonds',
		'sdf',
		'smiles',
		'inchi',
		'canost'
	],
	#classVars : [
		'Rand'
	],
	#category : 'ReactionMapViewer-GRRMImport'
}

{ #category : #converting }
RMapImportNode >> asRMapVertex [
	^ self rmapVertexClass fromJson: self json
]

{ #category : #accessing }
RMapImportNode >> dist: anRMapImportNode [
	^ position distance: anRMapImportNode position
]

{ #category : #accessing }
RMapImportNode >> energy [
	^ energy
]

{ #category : #accessing }
RMapImportNode >> energy: aNumber [
	energy := aNumber asNumber asFloat
]

{ #category : #accessing }
RMapImportNode >> gap [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMapImportNode >> geometry [
	^ geometry asArray
]

{ #category : #adding }
RMapImportNode >> geometryAdd: anArray [
	^ geometry
		add:
			{(anArray first asString).
			(anArray second asNumber asFloat).
			(anArray third asNumber asFloat).
			(anArray fourth asNumber asFloat)}
]

{ #category : #'initialize - release' }
RMapImportNode >> initialize [
	super initialize.
	geometry := OrderedCollection new.
	bonds := Array new.
	sdf := String new.
	smiles := String new.
	inchi := String new.
	canost := String new
]

{ #category : #accessing }
RMapImportNode >> json [
	| json |
	json := Dictionary new.
	json
		at: 'position'
			put:
				{(position x).
					(position y)};
		at: 'label' put: label;
		at: 'energy' put: energy;
		at: 'geometry' put: geometry;
		at: 'bonds' put: bonds;
		at: 'sdf' put: sdf;
		at: 'smiles' put: smiles;
		at: 'inchi' put: inchi.
	canost ifNotNil: [ json at: 'canost' put: canost ].
	^ json
]

{ #category : #accessing }
RMapImportNode >> label [
	^ label
]

{ #category : #accessing }
RMapImportNode >> label: aString [
	label := aString
]

{ #category : #accessing }
RMapImportNode >> position [
	^ position
]

{ #category : #accessing }
RMapImportNode >> position: aJun2dPoint [
	position := aJun2dPoint
]

{ #category : #printing }
RMapImportNode >> printOn: aStream [
	label
		ifNotNil: [ 
			aStream
				nextPut: $<;
				nextPutAll: label;
				nextPut: $> ]
		ifNil: [ super printOn: aStream ]
]

{ #category : #accessing }
RMapImportNode >> random [
	^ (Rand ifNil: [ Rand := Random new ]) next
]

{ #category : #babel }
RMapImportNode >> readBabel [
	sdf := JunBabelWrapper convert: self xyz from: 'xyz' to: 'mol'.
	bonds := Array
		new: 16
		streamContents: [ :stream | 
			JunBabelWrapper
				bondsFromMol: sdf
				do: [ :atom1 :atom2 :bond | 
					stream
						nextPut:
							{(atom1 - 1).
							(atom2 - 1).
							bond} ] ].
	smiles := ((JunBabelWrapper convert: self xyz from: 'xyz' to: 'can') lines first readStream upTo: Character tab) trim.
	inchi := ('InChI=' split: (JunBabelWrapper convert: self xyz from: 'xyz' to: 'inchi')) second lines first trim.
	canost := (JunBabelWrapper
		exec: (FileLocator imageDirectory / 'main_canost') fullName
		args:
			{'-u'.
			'f'.
			'/dev/stdin'.
			'/dev/stdout'}
		stdin: sdf) lines in: [ :lines | lines first trim ifEmpty: [ lines third trim ] ifNotEmpty: [ nil ] ]
]

{ #category : #accessing }
RMapImportNode >> rmapVertexClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMapImportNode >> x [
	^ position x
]

{ #category : #accessing }
RMapImportNode >> xyz [
	^ geometry size printString , String lf , String lf
		,
			(String lf
				join:
					(geometry
						collect: [ :quad | 
							quad first , String tab , (quad second printShowingDecimalPlaces: 12) , String tab
								, (quad third printShowingDecimalPlaces: 12) , String tab , (quad fourth printShowingDecimalPlaces: 12) ]))
		, String lf
]

{ #category : #accessing }
RMapImportNode >> y [
	^ position y
]
