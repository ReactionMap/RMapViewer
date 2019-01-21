Class {
	#name : #RMapInfoRenderer,
	#superclass : #RMapRenderer,
	#instVars : [
		'attributes'
	],
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #'instance creation' }
RMapInfoRenderer class >> default [
	^ self with: 'label' with: 'energy' with: 'smiles' with: 'inchi' with: 'canost'
]

{ #category : #'instance creation' }
RMapInfoRenderer class >> on: anRMapMorph [
	^ self default
		rmap: anRMapMorph;
		yourself
]

{ #category : #'instance creation' }
RMapInfoRenderer class >> with: aString [
	^ self new add: aString; yourself
]

{ #category : #'instance creation' }
RMapInfoRenderer class >> with: aString1 with: aString2 [
	^ self new
		add: aString1;
		add: aString2;
		yourself
]

{ #category : #'instance creation' }
RMapInfoRenderer class >> with: aString1 with: aString2 with: aString3 [
	^ self new
		add: aString1;
		add: aString2;
		add: aString3;
		yourself
]

{ #category : #'instance creation' }
RMapInfoRenderer class >> with: aString1 with: aString2 with: aString3 with: aString4 [
	^ self new
		add: aString1;
		add: aString2;
		add: aString3;
		add: aString4;
		yourself
]

{ #category : #'instance creation' }
RMapInfoRenderer class >> with: aString1 with: aString2 with: aString3 with: aString4 with: aString5 [
	^ self new
		add: aString1;
		add: aString2;
		add: aString3;
		add: aString4;
		add: aString5;
		yourself
]

{ #category : #'instance creation' }
RMapInfoRenderer class >> withAll: anArrayOfString [
	^ self new
		addAll: anArrayOfString;
		yourself
]

{ #category : #adding }
RMapInfoRenderer >> add: aString [
	 ^ attributes add: aString
]

{ #category : #adding }
RMapInfoRenderer >> addAll: anArrayOfString [
	 ^ attributes addAll: anArrayOfString
]

{ #category : #accessing }
RMapInfoRenderer >> edgePointsFor: anRMapVertex do: aBlock [
	| halfWidth halfHeight |
	(self formFor: anRMapVertex)
		in: [ :form | 
			halfWidth := form width / 2.0.
			halfHeight := form height / 2.0 ].
	(rmap projector value: anRMapVertex)
		ifNotNil: [ :position | 
			aBlock value: (position x - halfWidth) @ (position y - halfHeight).
			aBlock value: (position x + halfWidth) @ (position y - halfHeight).
			aBlock value: (position x - halfWidth) @ (position y + halfHeight).
			aBlock value: (position x + halfWidth) @ (position y + halfHeight) ]
]

{ #category : #accessing }
RMapInfoRenderer >> formsFor: anRMapVertex [
	| color font lines form |
	color := Color white.
	font := TextStyle default defaultFont.
	lines := attributes
		collect: [ :attribute | 
			attribute , ': '
				, (anRMapVertex at: attribute ifAbsentPut: [ 'N/A' ]) asString ].
	(rmap hasReactant: anRMapVertex)
		ifTrue: [ lines addFirst: 'Reactant' ].
	(rmap hasProduct: anRMapVertex)
		ifTrue: [ lines addFirst: 'Product' ].
	form := Form
		extent:
			((lines
				inject: 0
				into: [ :max :each | max max: (font widthOfString: each) ]) + 4)
				@ (lines size * font height + 4)
		depth: 32.
	form getCanvas
		in: [ :canvas | 
			canvas fillColor: color.
			canvas
				frameRectangle: (0 @ 0 corner: form extent)
				color: Color black.
			lines
				keysAndValuesDo:
					[ :index :line | canvas drawString: line at: 2 @ ((index - 1) * font height + 2) ] ].
	^ Array with: form
]

{ #category : #'initialize-release' }
RMapInfoRenderer >> initialize [
	super initialize.
	attributes := OrderedCollection new
]

{ #category : #accessing }
RMapInfoRenderer >> name [
	^'info'
]
