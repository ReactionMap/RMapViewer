Class {
	#name : #RMapMotionMoleculeViewer,
	#superclass : #ModelMorph,
	#instVars : [
		'motionMolecule',
		'moleculeIndex',
		'indexToT',
		'isPlaying',
		'moleculeViewer',
		'jumpToStartButton',
		'prevCaptionButton',
		'playPauseButton',
		'nextCaptionButton',
		'jumpToEndButton',
		'indexChangedAction',
		'jumpToEndIcon',
		'jumpToStartIcon',
		'pauseIcon',
		'playIcon',
		'emptyIcon'
	],
	#category : #'ReactionMapViewer-Morphs'
}

{ #category : #'instance creation' }
RMapMotionMoleculeViewer class >> on: anRMapMotionMolecule [
	^ self new
		motionMolecule: anRMapMotionMolecule;
		yourself
]

{ #category : #'user interface' }
RMapMotionMoleculeViewer >> build [
	self changeProportionalLayout.
	moleculeViewer := RMapMoleculeViewer new.
	self
		addMorph: moleculeViewer
		fullFrame:
			((0 @ 0 corner: 1 @ 1) asLayoutFrame
				bottomOffset: -45;
				yourself).
	jumpToStartButton := IconicButton new
		target: self;
		actionSelector: #jumpToStart;
		color: (Color gray: 0.95);
		labelGraphic: self jumpToStartIcon;
		yourself.
	self
		addMorph: jumpToStartButton
		fullFrame:
			((0 @ 1 corner: 0.2 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself).
	prevCaptionButton := SimpleButtonMorph new
		target: self;
		actionSelector: #jumpToPrevCaption;
		color: (Color gray: 0.95);
		label: '';
		yourself.
	self
		addMorph: prevCaptionButton
		fullFrame:
			((0.2 @ 1 corner: 0.4 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself).
	playPauseButton := IconicButton new
		target: self;
		actionSelector: #togglePlay;
		color: (Color gray: 0.95);
		labelGraphic: self playIcon;
		yourself.
	self
		addMorph: playPauseButton
		fullFrame:
			((0.4 @ 1 corner: 0.6 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself).
	nextCaptionButton := SimpleButtonMorph new
		target: self;
		actionSelector: #jumpToNextCaption;
		color: (Color gray: 0.95);
		label: '';
		yourself.
	self
		addMorph: nextCaptionButton
		fullFrame:
			((0.6 @ 1 corner: 0.8 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself).
	jumpToEndButton := IconicButton new
		target: self;
		actionSelector: #jumpToEnd;
		color: (Color gray: 0.95);
		labelGraphic: self jumpToEndIcon;
		yourself.
	self
		addMorph: jumpToEndButton
		fullFrame:
			((0.8 @ 1 corner: 1 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself)
]

{ #category : #private }
RMapMotionMoleculeViewer >> createIndexToT [
	| ts lastIndex |
	ts := Array new: motionMolecule size.
	ts isEmpty
		ifTrue: [ ^ ts ].
	lastIndex := 1.
	ts at: 1 put: 0.0.
	2 to: motionMolecule size do: [ :index | 
		(motionMolecule at: index) label
			ifNotNil: [ 
				lastIndex + 1 to: index do: [ :i | ts at: i put: (i - lastIndex) / (index - lastIndex) asFloat + (ts at: lastIndex) ].
				lastIndex := index ] ].
	^ ts collect: [ :t | t / ts last ]
]

{ #category : #drawing }
RMapMotionMoleculeViewer >> drawOn: aCanvas [
	| font xOffset yOffset xScale |
	font := TextStyle defaultFont.
	xOffset := self bounds left + 20.
	yOffset := self bounds bottom - 15.
	xScale := self bounds width - 40.
	aCanvas
		fillRectangle:
			(((indexToT at: 1) * xScale + xOffset) @ (yOffset - 4)
				corner: ((indexToT at: moleculeIndex) * xScale + xOffset) @ (yOffset - 2))
		color: Color darkGray.
	1 to: motionMolecule size do: [ :index | 
		(motionMolecule at: index) label
			ifNotNil: [ :caption | 
				| x |
				x := (indexToT at: index) * xScale + xOffset.
				aCanvas
					drawString: caption
						at: (x - ((font widthOfString: caption) * 0.5)) @ yOffset
						font: font
						color: Color black;
					line: x @ (yOffset - 5)
						to: x @ (yOffset - 2)
						width: 1
						color: Color gray ] ]
]

{ #category : #'user interface' }
RMapMotionMoleculeViewer >> emptyIcon [
	^ emptyIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			emptyIcon := form ]
]

{ #category : #accessing }
RMapMotionMoleculeViewer >> indexChangedAction [
	^ indexChangedAction
]

{ #category : #accessing }
RMapMotionMoleculeViewer >> indexChangedAction: aBlock [
	indexChangedAction := aBlock
]

{ #category : #'initialize-release' }
RMapMotionMoleculeViewer >> initialExtent [
	^ 200 @ 200
]

{ #category : #'initialize-release' }
RMapMotionMoleculeViewer >> initialize [
	super initialize.
	self extent: self initialExtent.
	self build
]

{ #category : #operations }
RMapMotionMoleculeViewer >> jumpToEnd [
	self moleculeIndex: motionMolecule size
]

{ #category : #'user interface' }
RMapMotionMoleculeViewer >> jumpToEndIcon [
	^ jumpToEndIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			form getCanvas
				line: 15 @ 4
					to: 15 @ 15
					width: 1
					color: Color black;
				line: 5 @ 10
					to: 15 @ 10
					width: 1
					color: Color black;
				line: 15 @ 10
					to: 11 @ 8
					width: 1
					color: Color black;
				line: 14 @ 10
					to: 11 @ 8
					width: 1
					color: Color black;
				line: 15 @ 10
					to: 11 @ 12
					width: 1
					color: Color black;
				line: 15 @ 10
					to: 11 @ 12
					width: 1
					color: Color black.
			jumpToEndIcon := form ]
]

{ #category : #operations }
RMapMotionMoleculeViewer >> jumpToNextCaption [
	| index |
	index := moleculeIndex.
	[ 
	index := index + 1.
	index <= motionMolecule size ]
		whileTrue: [ (motionMolecule at: index) label ifNotNil: [ ^ self moleculeIndex: index ] ].
	^ nil
]

{ #category : #operations }
RMapMotionMoleculeViewer >> jumpToPrevCaption [
	| index |
	index := moleculeIndex.
	[ 
	index := index - 1.
	index >= 1 ] whileTrue: [ (motionMolecule at: index) label ifNotNil: [ ^ self moleculeIndex: index ] ].
	^ nil
]

{ #category : #operations }
RMapMotionMoleculeViewer >> jumpToStart [
	self moleculeIndex: 1
]

{ #category : #'user interface' }
RMapMotionMoleculeViewer >> jumpToStartIcon [
	^ jumpToStartIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			form getCanvas
				line: 4 @ 4
					to: 4 @ 15
					width: 1
					color: Color black;
				line: 5 @ 10
					to: 15 @ 10
					width: 1
					color: Color black;
				line: 5 @ 10
					to: 9 @ 8
					width: 1
					color: Color black;
				line: 6 @ 10
					to: 9 @ 8
					width: 1
					color: Color black;
				line: 5 @ 10
					to: 9 @ 12
					width: 1
					color: Color black;
				line: 6 @ 10
					to: 9 @ 12
					width: 1
					color: Color black.
			jumpToStartIcon := form ]
]

{ #category : #accessing }
RMapMotionMoleculeViewer >> moleculeIndex [
	^ moleculeIndex
]

{ #category : #accessing }
RMapMotionMoleculeViewer >> moleculeIndex: anInteger [
	moleculeIndex := anInteger.
	(moleculeIndex between: 1 and: motionMolecule size)
		ifTrue: [ moleculeViewer molecule: (motionMolecule at: anInteger) ].
	self updateButtons.
	indexChangedAction ifNotNil: [ indexChangedAction cull: anInteger ].
	self changed: #moleculeIndex.
	self changed
]

{ #category : #accessing }
RMapMotionMoleculeViewer >> motionMolecule: anRMapMotionMolecule [
	motionMolecule := anRMapMotionMolecule.
	moleculeViewer fitToBoundingBox: anRMapMotionMolecule boundingBox.
	isPlaying := false.
	indexToT := self createIndexToT.
	self moleculeIndex: 1
]

{ #category : #accessing }
RMapMotionMoleculeViewer >> nextCaption [
	| index |
	index := moleculeIndex.
	[ 
	index := index + 1.
	index <= motionMolecule size ] whileTrue: [ (motionMolecule at: index) label ifNotNil: [ :caption | ^ caption ] ].
	^ nil
]

{ #category : #'user interface' }
RMapMotionMoleculeViewer >> openInWindow [
	^ self openInWindowLabeled: 'Molecule Viewer'
]

{ #category : #updating }
RMapMotionMoleculeViewer >> pause [
	playPauseButton labelGraphic: self playIcon.
	isPlaying := false.
	self stopStepping
]

{ #category : #'user interface' }
RMapMotionMoleculeViewer >> pauseIcon [
	^ pauseIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			form getCanvas
				line: 8 @ 7
					to: 8 @ 13
					width: 2
					color: Color black;
				line: 12 @ 7
					to: 12 @ 13
					width: 2
					color: Color black.
			pauseIcon := form ]
]

{ #category : #updating }
RMapMotionMoleculeViewer >> play [
	playPauseButton labelGraphic: self pauseIcon.
	isPlaying := true.
	self isStepping
		ifFalse: [ self startStepping ]
]

{ #category : #'user interface' }
RMapMotionMoleculeViewer >> playIcon [
	^ playIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			form getCanvas
				drawPolygon:
					{(5 @ 5).
					(5 @ 15).
					(15 @ 10)}
				color: Color black
				borderWidth: 0
				borderColor: Color black.
			playIcon := form ]
]

{ #category : #accessing }
RMapMotionMoleculeViewer >> prevCaption [
	| index |
	index := moleculeIndex.
	[ 
	index := index - 1.
	index >= 1 ] whileTrue: [ (motionMolecule at: index) label ifNotNil: [ :caption | ^ caption ] ].
	^ nil
]

{ #category : #'stepping and presenter' }
RMapMotionMoleculeViewer >> step [
	isPlaying = true
		ifFalse: [ 
			self stopStepping.
			^ self ].
	moleculeIndex < motionMolecule size
		ifTrue: [ self moleculeIndex: moleculeIndex + 1 ]
		ifFalse: [ 
			self pause.
			self updateButtons ]
]

{ #category : #'stepping and presenter' }
RMapMotionMoleculeViewer >> stepTime [
	^ (motionMolecule at: moleculeIndex) label ifNil: [ 100 ] ifNotNil: [ 1000 ]
]

{ #category : #operations }
RMapMotionMoleculeViewer >> togglePlay [
	isPlaying = true
		ifTrue: [ self pause ]
		ifFalse: [ self play ]
]

{ #category : #updating }
RMapMotionMoleculeViewer >> updateButtons [
	motionMolecule ifNil: [ ^ self ].
	jumpToStartButton
		labelGraphic:
			(moleculeIndex <= 1
				ifTrue: [ self emptyIcon ]
				ifFalse: [ self jumpToStartIcon ]).
	jumpToEndButton
		labelGraphic:
			(moleculeIndex >= motionMolecule size
				ifTrue: [ self emptyIcon ]
				ifFalse: [ self jumpToEndIcon ]).
	prevCaptionButton label: (self prevCaption ifNil: [ '' ]).
	nextCaptionButton label: (self nextCaption ifNil: [ '' ]).
	playPauseButton
		labelGraphic:
			(moleculeIndex >= motionMolecule size
				ifTrue: [ self emptyIcon ]
				ifFalse: [ 
					isPlaying = true
						ifTrue: [ self pauseIcon ]
						ifFalse: [ self playIcon ] ])
]
