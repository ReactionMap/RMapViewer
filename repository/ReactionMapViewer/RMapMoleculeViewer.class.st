Class {
	#name : #RMapMoleculeViewer,
	#superclass : #JunAbstract3dMorph,
	#instVars : [
		'molecule',
		'presentation',
		'label',
		'font'
	],
	#category : 'ReactionMapViewer-Morphs'
}

{ #category : #examples }
RMapMoleculeViewer class >> example1 [
	"RMapMoleculeViewer  example1"

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
	(RMapMoleculeViewer on: molecule) openInWindow
]

{ #category : #'class initialization' }
RMapMoleculeViewer class >> install [
	Smalltalk addToStartUpList: self
]

{ #category : #'instance creation' }
RMapMoleculeViewer class >> on: aJunMoleculeGeometry [
	^ self new
		molecule: aJunMoleculeGeometry;
		fit;
		yourself
]

{ #category : #'class initialization' }
RMapMoleculeViewer class >> startUp [
	FreeTypeFontProvider current updateFromSystem
]

{ #category : #menu }
RMapMoleculeViewer >> addYellowButtonMenuItemsTo: aMenu event: evt [
	"Populate aMenu with appropriate menu items for a  
	yellow-button (context menu) click."

	aMenu defaultTarget: self.
	self defaultYellowButtonMenuEnabled
		ifFalse: [ ^ self ].
	aMenu
		addStayUpItem
		addTitle: (label ifNil: ['Molecule Viewer']).
	aMenu
		add: 'presentation'
			subMenu:
				(MenuMorph new
						addToggle: 'stick and ball'
							target: self
							selector: #stickAndBallPresentation
							getStateSelector: #isStickAndBallPresentation;
						addToggle: 'tube'
							target: self
							selector: #tubePresentation
							getStateSelector: #isTubePresentation;
						addToggle: 'van der waals'
							target: self
							selector: #vanDerWaalsPresentation
							getStateSelector: #isVanDerWaalsPresentation;
						yourself);
		add: 'background'
			subMenu:
				(MenuMorph new
						addToggle: 'black'
							target: self
							selector: #blackBackground
							getStateSelector: #isBlackBackground;
						addToggle: 'white'
							target: self
							selector: #whiteBackground
							getStateSelector: #isWhiteBackground;
						add: 'color...' target: self selector: #chooseBackgroundColor;
						yourself)
]

{ #category : #accessing }
RMapMoleculeViewer >> blackBackground [
	self color: Color black
]

{ #category : #accessing }
RMapMoleculeViewer >> chooseBackgroundColor [
	(UIManager default theme chooseColorIn: UIManager default title: 'Choose a background color' color: self color)
		ifNotNil: [ :c | self color: c ]
]

{ #category : #defaults }
RMapMoleculeViewer >> defaultColor [
	^ Color black
]

{ #category : #menu }
RMapMoleculeViewer >> defaultYellowButtonMenuEnabled [
	^ true
]

{ #category : #drawing }
RMapMoleculeViewer >> drawOn: aCanvas [
	| form rc |
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
	rc flush.
	aCanvas drawImage: form at: self innerBounds origin.
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

{ #category : #menu }
RMapMoleculeViewer >> hasYellowButtonMenu [
	^ true
]

{ #category : #'initialize-release' }
RMapMoleculeViewer >> initialize [
	super initialize.
	self stickAndBallPresentation.
	self color: self defaultColor.
	font := FreeTypeFontProvider current
		fontFor:
			(LogicalFont
				familyName: 'Arial'
				pointSize: 24
				stretchValue: 5
				weightValue: LogicalFont weightBold
				slantValue: 0)
		familyName: 'Arial'.
	font
		ifNil: [ 
			FreeTypeFontProvider current updateFromSystem.
			font := FreeTypeFontProvider current
				fontFor:
					(LogicalFont
						familyName: 'Arial'
						pointSize: 24
						stretchValue: 5
						weightValue: LogicalFont weightBold
						slantValue: 0)
				familyName: 'Arial' ].
	font ifNil: [ font := TextStyle default defaultFont ]
]

{ #category : #testing }
RMapMoleculeViewer >> isBlackBackground [
	^ color = Color black
]

{ #category : #testing }
RMapMoleculeViewer >> isStickAndBallPresentation [
	^ presentation = #stickAndBall
]

{ #category : #testing }
RMapMoleculeViewer >> isTubePresentation [
	^ presentation = #tube
]

{ #category : #testing }
RMapMoleculeViewer >> isVanDerWaalsPresentation [
	^ presentation = #vanDerWaals
]

{ #category : #testing }
RMapMoleculeViewer >> isWhiteBackground [
	^ color = Color white
]

{ #category : #accessing }
RMapMoleculeViewer >> molecule: aJunMoleculeGeometry [
	molecule := aJunMoleculeGeometry.
	self changed
]

{ #category : #'event handling' }
RMapMoleculeViewer >> mouseDown: aMouseEvent [
	aMouseEvent yellowButtonPressed
		ifTrue: [ ^ self yellowButtonActivity: aMouseEvent shiftPressed ].
	super mouseDown: aMouseEvent
]

{ #category : #accessing }
RMapMoleculeViewer >> object [
	^ molecule
]

{ #category : #'user interface' }
RMapMoleculeViewer >> openInWindowLabeled: aString [
	| window | 
	window := super openInWindowLabeled: aString.
	self color: self defaultColor.
	label := aString.
	^ window
]

{ #category : #accessing }
RMapMoleculeViewer >> presentation [
	^ presentation
]

{ #category : #drawing }
RMapMoleculeViewer >> renderStickAndBallOn: aJunRenderingContext [
	molecule renderOn: aJunRenderingContext
]

{ #category : #drawing }
RMapMoleculeViewer >> renderTubeOn: aJunRenderingContext [
	molecule bondsDo: [ :bond | bond renderTubeOn: aJunRenderingContext ].
	molecule
		atomsDo: [ :atom | 
			| r |
			r := 0.15.
			aJunRenderingContext color: atom color.
			atom
				triangles128Do: [ :v1 :v2 :v3 | 
					aJunRenderingContext
						displayPolygon: (Array with: v1 * r + atom position with: v2 * r + atom position with: v3 * r + atom position)
						normalVectors: (Array with: v1 unitVector with: v2 unitVector with: v3 unitVector) ] ]
]

{ #category : #drawing }
RMapMoleculeViewer >> renderVanDerWaalsOn: aJunRenderingContext [
	(molecule size > 64 and: [ false ])
		ifTrue: [ 
			molecule
				atomsDo: [ :atom | 
					| r |
					r := atom vanDerWaalsRadius.
					aJunRenderingContext color: atom color.
					atom
						triangles128Do: [ :v1 :v2 :v3 | 
							aJunRenderingContext
								displayPolygon: (Array with: v1 * r + atom position with: v2 * r + atom position with: v3 * r + atom position)
								normalVectors: (Array with: v1 unitVector with: v2 unitVector with: v3 unitVector) ] ] ]
		ifFalse: [ 
			molecule
				atomsDo: [ :atom | 
					| r |
					r := atom vanDerWaalsRadius.
					aJunRenderingContext color: atom color.
					atom
						triangles512Do: [ :v1 :v2 :v3 | 
							aJunRenderingContext
								displayPolygon: (Array with: v1 * r + atom position with: v2 * r + atom position with: v3 * r + atom position)
								normalVectors: (Array with: v1 unitVector with: v2 unitVector with: v3 unitVector) ] ] ]
]

{ #category : #accessing }
RMapMoleculeViewer >> stickAndBallPresentation [
	presentation := #stickAndBall.
	self changed
]

{ #category : #accessing }
RMapMoleculeViewer >> tubePresentation [
	presentation := #tube.
	self changed
]

{ #category : #accessing }
RMapMoleculeViewer >> vanDerWaalsPresentation [
	presentation := #vanDerWaals.
	self changed
]

{ #category : #accessing }
RMapMoleculeViewer >> whiteBackground [
	self color: Color white
]

{ #category : #menu }
RMapMoleculeViewer >> yellowButtonActivity: shiftState [ 
	"Find me or my outermost owner that has items to add to a  
	yellow button menu.  
	shiftState is true if the shift was pressed.  
	Otherwise, build a menu that contains the contributions from  
	myself and my interested submorphs,  
	and present it to the user."
	| menu |
	self isWorldMorph
		ifFalse: [| outerOwner | 
			outerOwner := self outermostOwnerWithYellowButtonMenu.
			outerOwner
				ifNil: [^ false].
			outerOwner == self
				ifFalse: [^ outerOwner yellowButtonActivity: shiftState]].
	menu := self buildYellowButtonMenu: ActiveHand.
	menu popUpInWorld: self currentWorld.
	^ true
]
