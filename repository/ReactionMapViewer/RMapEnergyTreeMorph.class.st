Class {
	#name : #RMapEnergyTreeMorph,
	#superclass : #Morph,
	#instVars : [
		'rmapMorph',
		'font',
		'hoverVertex',
		'hoverError',
		'hoverHop',
		'hoverPoint'
	],
	#category : #'ReactionMapViewer-Morphs'
}

{ #category : #'instance creation' }
RMapEnergyTreeMorph class >> on: anRMapMorph [
	^ self new
		setRMapMorph: anRMapMorph;
		yourself
]

{ #category : #menu }
RMapEnergyTreeMorph >> addVertexMenu: aMenu [
	hoverVertex ifNotNil:[:v | 
		aMenu addTitle: v label.
		((rmapMorph hasProduct: v) or: [(rmapMorph hasReactant: v) or: [rmapMorph hasSelection: v]])
			ifTrue: [aMenu add: 'unselect' translated target: rmapMorph selector: #unselect: argument: v].
		(rmapMorph hasSelection: v)
			ifFalse: [aMenu add: 'select' translated target: rmapMorph selector: #addSelection: argument: v].
		(rmapMorph hasReactant: v)
			ifFalse: [aMenu add: 'reactant' translated target: rmapMorph selector: #addReactant: argument: v].
		(rmapMorph hasProduct: v)
			ifFalse: [aMenu add: 'product' translated target: rmapMorph selector: #addProduct: argument: v].
		aMenu addLine.
		aMenu add: 'open info' translated target: v selector: #openInfo.
		aMenu add: 'open in Jmol' translated target: v selector: #openJmol].
	^ aMenu
]

{ #category : #accessing }
RMapEnergyTreeMorph >> bandWidth [
	^ 70
]

{ #category : #accessing }
RMapEnergyTreeMorph >> bottomMargin [
	^ 20
]

{ #category : #drawing }
RMapEnergyTreeMorph >> drawEdgeFrom: anRMapVertex1 to: anRMapVertex2 hop: anInteger color: aColor on: aCanvas [
	| x1 x2 y1 y2 |
	x1 := anInteger + 0.75 * self bandWidth + self left.
	x2 := self bandWidth * 0.5 + x1.
	y1 := self yAtEnergy: anRMapVertex1 energy.
	y2 := self yAtEnergy: anRMapVertex2 energy.
	aCanvas line: x1@y1 to: x2@y2 color: aColor
]

{ #category : #drawing }
RMapEnergyTreeMorph >> drawHopsOn: aCanvas color: aColor [
	| agenda done hopCount |
	agenda := OrderedCollection new.
	done := Set new: 1024.
	rmapMorph
		reactantsDo: [ :vertex | 
			(rmapMorph isEffectiveVertex: vertex)
				ifTrue: [ agenda add: vertex ] ].
	hopCount := 0.
	[ agenda notEmpty ]
		whileTrue: [ 
			| newAgenda |
			newAgenda := OrderedCollection new: 1024.
			agenda
				do: [ :vertex | 
					self
						drawVertex: vertex
						hop: hopCount
						color: aColor
						on: aCanvas.
					done add: vertex.
					vertex
						edgesDo: [ :edge | 
							((done includes: edge vertex1) not and: [ rmapMorph isEffectiveVertex: edge vertex1 ])
								ifTrue: [ 
									self
										drawEdgeFrom: vertex
										to: edge vertex1
										hop: hopCount
										color: aColor
										on: aCanvas.
									newAgenda add: edge vertex1 ].
							((done includes: edge vertex2) not and: [ rmapMorph isEffectiveVertex: edge vertex2 ])
								ifTrue: [ 
									self
										drawEdgeFrom: vertex
										to: edge vertex2
										hop: hopCount
										color: aColor
										on: aCanvas.
									newAgenda add: edge vertex2 ] ] ].
			agenda := newAgenda.
			hopCount := hopCount + 1 ]
]

{ #category : #drawing }
RMapEnergyTreeMorph >> drawHoverVertex: anRMapVertex hop: anInteger on: aCanvas [
	| x1 y h |
	x1 := anInteger + 0.25 * self bandWidth + self left.
	y := self yAtEnergy: anRMapVertex energy.
	h := font height.
	aCanvas frameRectangle: ((x1)@(y- h - 2) extent: (self bandWidth * 0.5)@(h + 3)) width: 2 color: Color black.
	hoverVertex := anRMapVertex
]

{ #category : #drawing }
RMapEnergyTreeMorph >> drawOn: aCanvas [

	aCanvas fillRectangle: self bounds color: Color white.
	hoverError := TextStyle defaultFont height.
	hoverHop := nil.
	hoverPoint := self globalPointToLocal: World activeHand position.
	(self yAtEnergy: rmapMorph visibleEnergyRangeMax) in: [ :y | 
		aCanvas line: self left @ y to: self right @ y color: Color red ].
	(self yAtEnergy: rmapMorph visibleEnergyRangeMin) in: [ :y | 
		aCanvas line: self left @ y to: self right @ y color: Color red ].
	rmapMorph paths
		ifEmpty: [ self drawHopsOn: aCanvas color: Color lightGray ]
		ifNotEmpty: [ self drawPathsOn: aCanvas color: Color black ].
	hoverHop
		ifNotNil: [ 
		self drawHoverVertex: hoverVertex hop: hoverHop on: aCanvas ]
		ifNil: [ hoverVertex := nil ]
]

{ #category : #drawing }
RMapEnergyTreeMorph >> drawPathsOn: aCanvas color: aColor [
	| paths selectedPath hopCount shadowColor maxHopCount |
	paths := rmapMorph paths.
	selectedPath := rmapMorph selectedPath ifNil: [ Array new ].
	hopCount := 0.
	maxHopCount := paths inject: 0 into: [ :sum :path | sum max: path size ].
	shadowColor := aColor mixed: 0.2 with: Color white.
	[ hopCount <= maxHopCount ]
		whileTrue: [ 
			| vertices pairs |
			vertices := Set new: 1024.
			pairs := Set new: 1024.
			paths
				do: [ :path | 
					(path at: hopCount + 1 ifAbsent: [  ])
						ifNotNil: [ :vertex | 
							vertices add: vertex.
							(path at: hopCount + 2 ifAbsent: [  ]) ifNotNil: [ :vertex2 | pairs add: (Array with: vertex with: vertex2) ] ] ].
			vertices
				do: [ :vertex | 
					vertex ~= (selectedPath at: hopCount + 1 ifAbsent: [  ])
						ifTrue: [ 
							self
								drawVertex: vertex
								hop: hopCount
								color: shadowColor
								on: aCanvas ] ].
			pairs
				do: [ :pair | 
					(pair first = (selectedPath at: hopCount + 1 ifAbsent: [  ])
						and: [ pair second = (selectedPath at: hopCount + 2 ifAbsent: [  ]) ])
						ifFalse: [ 
							self
								drawEdgeFrom: pair first
								to: pair second
								hop: hopCount
								color: shadowColor
								on: aCanvas ] ].
			(selectedPath at: hopCount + 1 ifAbsent: [  ])
				ifNotNil: [ :vertex | 
					self
						drawVertex: vertex
						hop: hopCount
						color: aColor
						on: aCanvas.
					(selectedPath at: hopCount + 2 ifAbsent: [  ])
						ifNotNil: [ :vertex2 | 
							self
								drawEdgeFrom: vertex
								to: vertex2
								hop: hopCount
								color: aColor
								on: aCanvas ] ].
			hopCount := hopCount + 1 ]
]

{ #category : #drawing }
RMapEnergyTreeMorph >> drawVertex: anRMapVertex hop: anInteger color: aColor on: aCanvas [
	| x1 x2 y w h |
	x1 := (anInteger + 0.25) * self bandWidth + self left.
	x2 := self bandWidth * 0.5 + x1.
	y := self yAtEnergy: anRMapVertex energy.
	w := font widthOfString: anRMapVertex label.
	h := font height.
	((hoverPoint x between: x1 and: x2) and: [ (hoverPoint y between: y - h - 4 and: y) and: [ (hoverPoint y - y) abs < hoverError ]])
		ifTrue: [ 
			hoverVertex := anRMapVertex.
			hoverError := (hoverPoint y - y) abs.
			hoverHop := anInteger ].
	aCanvas
		line: (x1 + 1) @ (y - 1)
		to: (x2 - 1) @ (y - 1)
		width: 3
		color: aColor.
	w := font widthOfString: anRMapVertex label.
	h := font height.
	aCanvas
		drawString: anRMapVertex label
		at: (self bandWidth * 0.25 + x1 - (w / 2.0)) @ (y - h - 2)
		font: font
		color: aColor
]

{ #category : #'event handling' }
RMapEnergyTreeMorph >> handlesMouseDown: event [
	^ true
]

{ #category : #private }
RMapEnergyTreeMorph >> hops [
	^ rmapMorph paths
		ifEmpty: [ 
			| agenda done hopCount |
			agenda := OrderedCollection new.
			done := Set new: 1024.
			rmapMorph
				reactantsDo: [ :vertex | 
					(rmapMorph isEffectiveVertex: vertex)
						ifTrue: [ agenda add: vertex ] ].
			hopCount := 0.
			[ agenda notEmpty ]
				whileTrue: [ 
					| newAgenda |
					newAgenda := OrderedCollection new: 1024.
					agenda
						do: [ :vertex | 
							done add: vertex.
							vertex
								edgesDo: [ :edge | 
									((done includes: edge vertex1) not and: [ rmapMorph isEffectiveVertex: edge vertex1 ])
										ifTrue: [ newAgenda add: edge vertex1 ].
									((done includes: edge vertex2) not and: [ rmapMorph isEffectiveVertex: edge vertex2 ])
										ifTrue: [ newAgenda add: edge vertex2 ] ] ].
					agenda := newAgenda.
					hopCount := hopCount + 1 ].
			hopCount ]
		ifNotEmpty: [ :paths | paths inject: 0 into: [ :sum :path | sum max: path size ] ]
]

{ #category : #'initialize-release' }
RMapEnergyTreeMorph >> initialize [
	super initialize.
	font := TextStyle default defaultFont
]

{ #category : #'event handling' }
RMapEnergyTreeMorph >> mouseDown: anEvent [
	hoverVertex
		ifNotNil: [ 
			(self addVertexMenu: (UIManager default newMenuIn: self for: self))
				ifNotNil: [ :menu | 
					menu setInvokingView: self.
					menu popUpEvent: self activeHand lastEvent in: self world ] ]
]

{ #category : #private }
RMapEnergyTreeMorph >> setRMapMorph: anRMapMorph [
	rmapMorph
		ifNotNil: [ 
			rmapMorph pathSelector removeDependent: self.
			rmapMorph removeDependent: self ].
	rmapMorph := anRMapMorph.
	rmapMorph addDependent: self.
	rmapMorph pathSelector addDependent: self
]

{ #category : #'stepping and presenter' }
RMapEnergyTreeMorph >> step [
	(self owner bounds containsPoint: World activeHand position)
		ifTrue: [ self changed ]
]

{ #category : #'stepping and presenter' }
RMapEnergyTreeMorph >> stepTime [
	^ 500
]

{ #category : #accessing }
RMapEnergyTreeMorph >> topMargin [
	^ 30
]

{ #category : #updating }
RMapEnergyTreeMorph >> update: aSymbol [
	(#(#selection #visibleEnergyRangeMin #visibleEnergyRangeMax #index #paths) includes: aSymbol)
		ifTrue: [ 
			self updateExtent.
			self changed ]
]

{ #category : #updating }
RMapEnergyTreeMorph >> updateExtent [
	self extent: (self hops * self bandWidth max: owner width) @ (owner height + 16).
	owner
		ifNotNil: [ 
			owner owner
				ifNotNil: [ :scrollPane | 
					scrollPane hSetScrollDelta.
					scrollPane hScrollBar color: World theme windowColor.]]
]

{ #category : #accessing }
RMapEnergyTreeMorph >> yAtEnergy: aNumber [
	| min max y |
	min := rmapMorph energyRangeMin.
	max := rmapMorph energyRangeMax.
	y := (max - aNumber) * (self height - self topMargin - self bottomMargin) / (max - min) + self topMargin + self top.
	y isNaN
		ifTrue: [ y := 0 ].
	^ y
]
