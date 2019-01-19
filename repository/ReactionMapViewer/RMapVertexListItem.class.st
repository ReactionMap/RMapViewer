Class {
	#name : #RMapVertexListItem,
	#superclass : #Object,
	#instVars : [
		'vertex',
		'form'
	],
	#classInstVars : [
		'cachedForm',
		'lock'
	],
	#category : #'ReactionMapViewer-Support'
}

{ #category : #utilities }
RMapVertexListItem class >> critical: aBlock [
	lock critical: aBlock
]

{ #category : #utilities }
RMapVertexListItem class >> formFor: anRMapVertex [
	| molecule box center projection rc |
	self
		critical: [ cachedForm
				ifNil: [ cachedForm := Form
						extent: self listIconSize @ self listIconSize
						depth: 32 ].
			molecule := RMapMolecule new.
			anRMapVertex
				geometry2dDo:
					[ :atom :x :y :z | molecule add: (JunAtom symbol: atom at: (Jun3dPoint x: x y: y z: z)) ].
			molecule autoBonds.
			box := molecule boundingBox.
			center := box center.
			projection := JunParallelProjection
				eyePoint: (0 ,, 0 ,, (box depth * 2)) + center
				sightPoint: center
				upVector: 0 ,, 1 ,, 0
				height: (box width max: box height)
				near: 0.1
				far: box depth * 10.
			rc := cachedForm renderingContext.
			rc enableCullface.
			rc backgroundColor: Color transparent.
			rc projection: projection.
			rc clear.
			rc ambientLight: Color gray.
			rc
				lightIndex: 0
				parallel: projection eyePoint negated
				color: Color gray.
			molecule renderOn: rc.
			rc flush.
			^ cachedForm copy: (0 @ 0 extent: cachedForm extent) ]
]

{ #category : #initialization }
RMapVertexListItem class >> initialize [
	lock := Semaphore forMutualExclusion.
	SessionManager default
		registerSystemClassNamed: self name
		atPriority: 100
]

{ #category : #constants }
RMapVertexListItem class >> listIconSize [
	^ 64
]

{ #category : #'instance creation' }
RMapVertexListItem class >> on: anRMapVertex [
	^ self new
		vertex: anRMapVertex;
		yourself
]

{ #category : #'system startup' }
RMapVertexListItem class >> startUp: aBoolean [
	cachedForm := nil
]

{ #category : #accessing }
RMapVertexListItem >> form [
	^ form ifNil: [ form := self class formFor: self vertex ]
]

{ #category : #accessing }
RMapVertexListItem >> form: aForm [
	form := aForm
]

{ #category : #'list icon support' }
RMapVertexListItem >> heightToDisplayInList: aListMorph [
	^ 64
]

{ #category : #'list icon support' }
RMapVertexListItem >> listRenderOn: aCanvas atRow: row bounds: aRectangle color: aColor backgroundColor: backgroundColor from: aListMorph [
	"aCanvas fillRectangle: aRectangle color: backgroundColor."

	"aCanvas paintImage: self form at: aRectangle topLeft"

	aCanvas
		drawString: vertex label
		at: 2 @ ((64 - TextStyle defaultFont height) / 2.0) + aRectangle topLeft.
	aCanvas paintImage: self form at: aRectangle topLeft + (70 @ 0)
]

{ #category : #accessing }
RMapVertexListItem >> vertex [
	^ vertex
]

{ #category : #accessing }
RMapVertexListItem >> vertex: anRMapVertex [
	vertex := anRMapVertex
]

{ #category : #'list icon support' }
RMapVertexListItem >> widthToDisplayInList: aListMorph [
	^ 150
]
