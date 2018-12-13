Class {
	#name : #RMapMoleculeMeasure,
	#superclass : #RMapMoleculeViewer,
	#instVars : [
		'measureMode',
		'dragSource',
		'dropTarget',
		'atoms'
	],
	#category : 'ReactionMapViewer-Morphs'
}

{ #category : #examples }
RMapMoleculeMeasure class >> example1 [
	"RMapMoleculeMeasure example1"

	| molecule |
	molecule := JunMoleculeGeometry
		fromXYZ:
			'5
methane molecule (in ångströms) from https://en.wikipedia.org/wiki/XYZ_file_format
C        0.000000        0.000000        0.000000
H        0.000000        0.000000        1.089000
H        1.026719        0.000000       -0.363000
H       -0.513360       -0.889165       -0.363000
H       -0.513360        0.889165       -0.363000'.
	molecule autoBonds.
	(RMapMoleculeMeasure on: molecule) openInWindow
]

{ #category : #'accessing-atoms' }
RMapMoleculeMeasure >> activeAtoms [
	^ atoms copyFrom: 1 to: self activeAtomsSize
]

{ #category : #testing }
RMapMoleculeMeasure >> activeAtomsIncludes: aJunAtom [
	1 to: self activeAtomsSize do: [ :index | 
		(atoms at: index) == aJunAtom
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'accessing-atoms' }
RMapMoleculeMeasure >> activeAtomsSize [
	self isDistanceMode
		ifTrue: [ ^ 2 ].
	self isAngleMode
		ifTrue: [ ^ 3 ].
	self isDihedralAngleMode
		ifTrue: [ ^ 4 ].
	^ 0
]

{ #category : #menu }
RMapMoleculeMeasure >> addYellowButtonMenuItemsTo: aMenu event: evt [
	"Populate aMenu with appropriate menu items for a  
	yellow-button (context menu) click."

	super addYellowButtonMenuItemsTo: aMenu event: evt.
	aMenu
		add: 'measure mode'
		subMenu:
			(MenuMorph new
				addToggle: 'distance'
					target: self
					selector: #setDistanceMode
					getStateSelector: #isDistanceMode;
				addToggle: 'angle'
					target: self
					selector: #setAngleMode
					getStateSelector: #isAngleMode;
				addToggle: 'dihedral angle'
					target: self
					selector: #setDihedralAngleMode
					getStateSelector: #isDihedralAngleMode;
				yourself)
]

{ #category : #constants }
RMapMoleculeMeasure >> angleMode [
	^ #angle
]

{ #category : #accessing }
RMapMoleculeMeasure >> angleString [
	| p1 p2 p3 |
	p1 := atoms first position.
	p2 := atoms second position.
	p3 := atoms third position.
	^ ((Jun3dLine from: p2 to: p1) angleWithLine: (Jun3dLine from: p2 to: p3)) deg printShowingDecimalPlaces: 3
]

{ #category : #'accessing-atoms' }
RMapMoleculeMeasure >> atomAt: anInteger [
	^ atoms at: anInteger
]

{ #category : #'accessing-atoms' }
RMapMoleculeMeasure >> atomAt: anInteger put: aJunAtom [
	1 to: atoms size do: [ :index | 
		(index ~= anInteger and: [ (atoms at: index) == aJunAtom ])
			ifTrue: [ atoms at: index put: (atoms at: anInteger) ] ].
	atoms at: anInteger put: aJunAtom.
	self changed.
	^ aJunAtom
]

{ #category : #'accessing-cursor' }
RMapMoleculeMeasure >> atomAtCursor [
	| atom distance line |
	atom := nil.
	distance := 0.3.
	line := Jun3dLine from: projection eyePoint to: self cursor3dPoint.
	1 to: molecule size do: [ :index | 
		| a d |
		a := molecule at: index.
		d := line distanceFromPoint: a position.
		d < distance
			ifTrue: [ 
				distance := d.
				atom := a ] ].
	^ atom
]

{ #category : #'accessing-cursor' }
RMapMoleculeMeasure >> cursor2dPoint [
	^ (ActiveHand position - self innerBounds center) * (2.0 @ -2.0) / self innerBounds height
]

{ #category : #'accessing-cursor' }
RMapMoleculeMeasure >> cursor3dPoint [
	^ projection translateTo3dPointFromPoint: self cursor2dPoint depth: projection distance
]

{ #category : #defaults }
RMapMoleculeMeasure >> defaultMode [
	^ self distanceMode
]

{ #category : #constants }
RMapMoleculeMeasure >> dihedralAngleMode [
	^ #faceAngle
]

{ #category : #accessing }
RMapMoleculeMeasure >> dihedralAngleString [
	| p1 p2 p3 p4 |
	p1 := atoms first position.
	p2 := atoms second position.
	p3 := atoms third position.
	p4 := atoms fourth position.
	^ ((JunPlane on: p1 on: p2 on: p3) angleWithPlane: (JunPlane on: p2 on: p3 on: p4)) deg printShowingDecimalPlaces: 3
]

{ #category : #constants }
RMapMoleculeMeasure >> distanceMode [
	^ #distance
]

{ #category : #accessing }
RMapMoleculeMeasure >> distanceString [
	^ ((atoms at: 1) position distance: (atoms at: 2) position) printShowingDecimalPlaces: 5
]

{ #category : #drawing }
RMapMoleculeMeasure >> drawOn: aCanvas [
	| form rc measureString |
	form := Form extent: self innerBounds extent depth: 32.
	rc := [ form renderingContext ]
		on: Error
		do: [ :ex | nil ].
	rc
		ifNil: [ 
			rc := [ form renderingContext ]
				on: Error
				do: [ :ex | nil ] ].
	rc
		ifNil: [ 
			rc := [ form renderingContext ]
				on: Error
				do: [ :ex | nil ] ].
	rc ifNil: [ ^ self ].
	rc enableCullface.
	rc backgroundColor: self color.
	rc projection: projection.
	rc clear.
	rc ambientLight: Color gray.
	rc lightIndex: 0 parallel: projection eyePoint negated color: Color gray.
	presentation = #tube
		ifTrue: [ self renderTubeOn: rc ]
		ifFalse: [ 
			presentation = #vanDerWaals
				ifTrue: [ self renderVanDerWaalsOn: rc ]
				ifFalse: [ self renderStickAndBallOn: rc ] ].
	self isDistanceMode
		ifTrue: [ self renderDistanceMeasure: rc ].
	self isAngleMode
		ifTrue: [ self renderAngleMeasure: rc ].
	self isDihedralAngleMode
		ifTrue: [ self renderDihedralAngleMeasure: rc ].
	rc flush.
	aCanvas translucentImage: form at: self innerBounds origin.
	measureString := self measureString.
	aCanvas
		drawString: measureString
		at: self bounds topRight - (((font widthOfString: measureString) + 10) @ -10)
		font: font
		color: Color white.
	molecule label
		ifNotNil: [ :caption | 
			aCanvas
				drawString: caption
				at: self bounds bottomCenter - (((font widthOfString: caption) / 2.0) @ (font height * 1.2))
				font: font
				color:
					(self isWhiteBackground
						ifTrue: [ Color black ]
						ifFalse: [ Color white ]) ]
]

{ #category : #'event handling' }
RMapMoleculeMeasure >> handleMouseDown: aMouseEvent [
	self atomAtCursor
		ifNotNil: [ :atom | 
			(self activeAtomsIncludes: atom)
				ifTrue: [ 
					dragSource := atom.
					aMouseEvent wasHandled: true.
					self changed.
					^ self ] ].
	^ super handleMouseDown: aMouseEvent
]

{ #category : #'event handling' }
RMapMoleculeMeasure >> handleMouseMove: aMouseEvent [
	aMouseEvent redButtonPressed
		ifTrue: [ 
			dragSource
				ifNotNil: [ 
					| atom |
					atom := self atomAtCursor.
					(self activeAtomsIncludes: atom)
						ifTrue: [ atom := nil ].
					dropTarget := self atomAtCursor.
					aMouseEvent wasHandled: true.
					self changed.
					^ self ] ].
	^ super handleMouseMove: aMouseEvent
]

{ #category : #'event handling' }
RMapMoleculeMeasure >> handleMouseUp: aMouseEvent [
	dragSource
		ifNotNil: [ 
			dropTarget ifNotNil: [ self atomAt: (atoms indexOf: dragSource) put: dropTarget ].
			dragSource := nil.
			dropTarget := nil.
			aMouseEvent wasHandled: true.
			^ self changed ].
	^ super handleMouseUp: aMouseEvent
]

{ #category : #'initialize-release' }
RMapMoleculeMeasure >> initialize [
	super initialize.
	atoms := Array new: 4.
	measureMode := #distance.
	dragSource := nil.
	dropTarget := nil
]

{ #category : #testing }
RMapMoleculeMeasure >> isAngleMode [
	^ measureMode = self angleMode
]

{ #category : #testing }
RMapMoleculeMeasure >> isDihedralAngleMode [
	^ measureMode = self dihedralAngleMode
]

{ #category : #testing }
RMapMoleculeMeasure >> isDistanceMode [
	^ measureMode = self distanceMode
]

{ #category : #'accessing-modes' }
RMapMoleculeMeasure >> measureMode [
	^ measureMode
]

{ #category : #accessing }
RMapMoleculeMeasure >> measureString [
	self isDistanceMode
		ifTrue: [ ^ self distanceString ].
	self isAngleMode
		ifTrue: [ ^ self angleString ].
	self isDihedralAngleMode
		ifTrue: [ ^ self dihedralAngleString ].
	^ 'N/A' copy
]

{ #category : #accessing }
RMapMoleculeMeasure >> molecule: aJunMoleculeGeometry [
	1 to: (aJunMoleculeGeometry size min: atoms size) do: [ :index | atoms at: index put: (aJunMoleculeGeometry at: index) ].
	^ super molecule: aJunMoleculeGeometry
]

{ #category : #drawing }
RMapMoleculeMeasure >> renderAngleMeasure: aJunRenderingContext [
	| atom1 atom2 atom3 v1 v2 |
	atom1 := atoms first.
	atom2 := atoms second.
	atom3 := atoms third.
	v1 := (atom1 position - atom2 position) unitVector * 0.5.
	v2 := (atom3 position - atom2 position) unitVector * 0.5.
	aJunRenderingContext
		disableLighting;
		disableDepthTest;
		color: Color yellow;
		displayLines:
				{(atom1 position + v1).
					(atom2 position)};
		displayLines:
				{(atom3 position + v2).
					(atom2 position)};
		enableLighting;
		enableDepthTest
]

{ #category : #drawing }
RMapMoleculeMeasure >> renderDihedralAngleMeasure: aJunRenderingContext [
	| atom1 atom2 atom3 atom4 |
	atom1 := atoms first.
	atom2 := atoms second.
	atom3 := atoms third.
	atom4 := atoms fourth.
	aJunRenderingContext
		disableLighting;
		disableCullface;
		color: (Color blue alpha: 0.5);
		displayPolygon:
				{(atom1 position).
					(atom2 position).
					(atom3 position)};
		color: (Color yellow alpha: 0.5);
		displayPolygon:
				{(atom2 position).
					(atom3 position).
					(atom4 position)};
		enableCullface;
		disableDepthTest;
		color: Color blue;
		displayLines:
				{(atom1 position).
					(atom2 position)};
		displayLines:
				{(atom3 position).
					(atom1 position)};
		color: Color yellow;
		displayLines:
				{(atom3 position).
					(atom4 position)};
		displayLines:
				{(atom4 position).
					(atom2 position)};
		color: Color cyan;
		displayLines:
				{(atom2 position).
					(atom3 position)};
		enableDepthTest;
		enableLighting
]

{ #category : #drawing }
RMapMoleculeMeasure >> renderDistanceMeasure: aJunRenderingContext [
	| atom1 atom2 v |
	atom1 := atoms first.
	atom2 := atoms second.
	v := (atom2 position - atom1 position crossProduct: projection sightVector) unitVector * 0.5.
	aJunRenderingContext
		disableLighting;
		disableDepthTest;
		color: Color yellow;
		displayLines:
				{(atom1 position).
					(atom1 position + v)};
		displayLines:
				{(atom2 position).
					(atom2 position + v)};
		displayLines:
				{(atom1 position + (v * 0.8)).
					(atom2 position + (v * 0.8))};
		enableLighting;
		enableDepthTest
]

{ #category : #drawing }
RMapMoleculeMeasure >> renderStickAndBallOn: aJunRenderingContext [
	dragSource
		ifNil: [ super renderStickAndBallOn: aJunRenderingContext ]
		ifNotNil: [ 
			molecule
				atomsDo: [ :atom | 
					((dragSource ~~ atom and: [ self activeAtomsIncludes: atom ]) or: [ atom == dropTarget ])
						ifTrue: [ aJunRenderingContext solidPresentation ]
						ifFalse: [ aJunRenderingContext wireframePresentation ].
					atom renderOn: aJunRenderingContext ].
			aJunRenderingContext wireframePresentation.
			molecule bondsDo: [ :bond | bond renderOn: aJunRenderingContext ].
			aJunRenderingContext solidPresentation ]
]

{ #category : #drawing }
RMapMoleculeMeasure >> renderTubeOn: aJunRenderingContext [
	dragSource ifNil: [ super renderTubeOn: aJunRenderingContext ].
	aJunRenderingContext wireframePresentation.
	molecule bondsDo: [ :bond | bond renderTubeOn: aJunRenderingContext ].
	molecule
		atomsDo: [ :atom | 
			| r |
			r := 0.15.
			aJunRenderingContext color: atom color.
			((dragSource ~~ atom and: [ self activeAtomsIncludes: atom ]) or: [ atom == dropTarget ])
				ifTrue: [ aJunRenderingContext solidPresentation ]
				ifFalse: [ aJunRenderingContext wireframePresentation ].
			atom
				triangles128Do: [ :v1 :v2 :v3 | 
					aJunRenderingContext
						displayPolygon: (Array with: v1 * r + atom position with: v2 * r + atom position with: v3 * r + atom position)
						normalVectors: (Array with: v1 unitVector with: v2 unitVector with: v3 unitVector) ] ].
	aJunRenderingContext solidPresentation
]

{ #category : #'accessing-modes' }
RMapMoleculeMeasure >> setAngleMode [
	molecule size < 3
		ifTrue: [ ^ self ].
	measureMode := self angleMode.
	self changed
]

{ #category : #'accessing-modes' }
RMapMoleculeMeasure >> setDihedralAngleMode [
	molecule size < 4
		ifTrue: [ ^ self ].
	measureMode := self dihedralAngleMode.
	self changed
]

{ #category : #'accessing-modes' }
RMapMoleculeMeasure >> setDistanceMode [
	molecule size < 2
		ifTrue: [ ^ self ].
	measureMode := self distanceMode.
	self changed
]

{ #category : #accessing }
RMapMoleculeMeasure >> tip [
	presentation = #stickAndBall
		ifTrue: [ ^ 0.6 ].
	presentation = #tube
		ifTrue: [ ^ 0.5 ].
	presentation = #vanDerWaals
		ifTrue: [ ^ 3.0 ].
	^ 1.0
]
