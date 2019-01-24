Class {
	#name : #RMapRenderer,
	#superclass : #Object,
	#instVars : [
		'rmap',
		'step',
		'substep'
	],
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #'instance creation' }
RMapRenderer class >> on: anRMapMorph [
	^ self new
		rmap: anRMapMorph;
		yourself
]

{ #category : #'accessing-edge points' }
RMapRenderer >> centerEdgePointsFor: anRMapVertex do: aBlock [
	(rmap positionFor: anRMapVertex) ifNotNil: aBlock
]

{ #category : #drawing }
RMapRenderer >> drawEdge: anRMapEdge color: aColor on: aCanvas [
	(rmap isEffectiveEdge: anRMapEdge )
		ifTrue: [ 
			self
				edgePointsBetween: anRMapEdge vertex1
				and: anRMapEdge vertex2
				do: [ :p1 :p2 | 
					(p1 notNil
						and: [ 
							p2 notNil
								and: [ 
									((p1 x between: 0.0 and: rmap width) and: [ p1 y between: 0.0 and: rmap height ])
										or: [ (p2 x between: 0.0 and: rmap width) and: [ p2 y between: 0.0 and: rmap height ] ] ] ])
						ifTrue: [ 
							aCanvas
								line: p1
								to: p2
								width: 1
								color: Color black ] ] ]
]

{ #category : #drawing }
RMapRenderer >> drawVertex: anRMapVertex borderColor: aColor on: aCanvas [
	^ (rmap isEffectiveVertex: anRMapVertex)
		ifTrue: [ (rmap positionFor: anRMapVertex)
				ifNotNil: [ :p | 
					((p x between: 0.0 and: rmap width asFloat)
						and: [ p y between: 0.0 and: rmap height asFloat ])
						ifTrue: [ | label rect |
							label := self formFor: anRMapVertex.
							label
								ifNotNil: [ rect := p - (label extent / 2.0 + 2) extent: label extent + 4.
									aColor
										ifNotNil: [ aCanvas frameRectangle: rect width: 2 color: aColor ].
									aCanvas paintImage: label at: p - (label extent / 2.0).
									rect ] ]
						ifFalse: [ nil ] ] ]
		ifFalse: [ nil ]
]

{ #category : #'accessing-edge points' }
RMapRenderer >> edgePointsBetween: anRMapVertex1 and: anRMapVertex2 do: aBlock [
	| point1 point2 minDistance |
	point1 := nil.
	point2 := nil.
	minDistance := Float fmax.
	self
		edgePointsFor: anRMapVertex1
		do: [ :p1 | 
			self
				edgePointsFor: anRMapVertex2
				do: [ :p2 | 
					| d |
					d := p1 dist: p2.
					d < minDistance
						ifTrue: [ 
							minDistance := d.
							point1 := p1.
							point2 := p2 ] ] ].
	point1 ifNotNil: [ point2 ifNotNil: [ aBlock value: point1 value: point2 ] ]
]

{ #category : #'accessing-edge points' }
RMapRenderer >> edgePointsFor: anRMapVertex do: aBlock [
	self centerEdgePointsFor: anRMapVertex do: aBlock
]

{ #category : #drawing }
RMapRenderer >> forceDrawVertex: anRMapVertex borderColor: aColor on: aCanvas [
	^ (rmap isEffectiveVertex: anRMapVertex)
		ifTrue: [ (rmap positionFor: anRMapVertex)
				ifNotNil: [ :p | 
					((p x between: 0.0 and: rmap width asFloat)
						and: [ p y between: 0.0 and: rmap height asFloat ])
						ifTrue: [ | label rect |
							label := self formFromForms: (self formsFor: anRMapVertex).
							label
								ifNotNil: [ rect := p - (label extent / 2.0 + 2) extent: label extent + 4.
									aColor
										ifNotNil: [ aCanvas frameRectangle: rect width: 2 color: aColor ].
									aCanvas paintImage: label at: p - (label extent / 2.0).
									rect ] ]
						ifFalse: [ nil ] ] ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
RMapRenderer >> formFor: anRMapVertex [
	^ self
		formFromForms:
			(anRMapVertex forms
				ifNil: [ anRMapVertex
						renderFormsWith: self;
						forms ])
]

{ #category : #accessing }
RMapRenderer >> formFromForms: anArrayOfForms [
	^ anArrayOfForms
		ifNil: [ nil ]
		ifNotNil: [ anArrayOfForms
				ifEmpty: [ nil ]
				ifNotEmpty: [ anArrayOfForms at: step \\ anArrayOfForms size + 1 ] ]
]

{ #category : #accessing }
RMapRenderer >> formsFor: anRMapVertex [ 
	^ self subclassResponsibility
]

{ #category : #'initialize-release' }
RMapRenderer >> initialize [
	super initialize.
	step := 1.
	substep := 1.
]

{ #category : #'accessing-edge points' }
RMapRenderer >> leftAndRightEdgePointsFor: anRMapVertex do: aBlock [
	| halfWidth |
	halfWidth := (self formFor: anRMapVertex) width / 2.0.
	(rmap positionFor: anRMapVertex)
		ifNotNil: [ :position | 
			aBlock value: (position x - halfWidth) @ position y.
			aBlock value: (position x + halfWidth) @ position y ]
]

{ #category : #accessing }
RMapRenderer >> name [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMapRenderer >> numVertices: anInteger [

]

{ #category : #'accessing-forms' }
RMapRenderer >> plainLabelFormsFor: anRMapVertex [
	| label color font lines form |
	label := anRMapVertex label.
	color := label first = $E
		ifTrue: [ Color lightGray ]
		ifFalse: [ Color white ].
	font := TextStyle default defaultFont.
	lines := (label substrings: String cr) ifEmpty: [ Array with: anRMapVertex position printString ].
	form := Form
		extent:
			((lines inject: 0 into: [ :max :each | max max: (font widthOfString: each) ]) + 2) @ (lines size * font height + 2)
		depth: 32.
	form getCanvas
		in: [ :canvas | 
			canvas fillColor: color.
			lines
				keysAndValuesDo: [ :index :line | canvas drawString: line at: (((form width - (font widthOfString: line)) // 2) @ index - 1) * font height + 1 ] ].
	^ Array with: form
]

{ #category : #printing }
RMapRenderer >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #drawing }
RMapRenderer >> rectangleFor: anRMapVertex [
	^ (rmap isEffectiveVertex: anRMapVertex)
		ifTrue: [ (rmap positionFor: anRMapVertex)
				ifNotNil: [ :p | 
					((p x between: 0.0 and: rmap width asFloat)
						and: [ p y between: 0.0 and: rmap height asFloat ])
						ifTrue: [ | label rect |
							label := anRMapVertex form.
							label
								ifNotNil: [ p - (label extent / 2.0 + 2) extent: label extent + 4 ] ]
						ifFalse: [ nil ] ] ]
]

{ #category : #accessing }
RMapRenderer >> rmap [
	^rmap
]

{ #category : #accessing }
RMapRenderer >> rmap: anRMapMorph [ 
	rmap := anRMapMorph
]

{ #category : #stepping }
RMapRenderer >> step [
	substep := substep + 1.
	substep > 2
		ifTrue: [ 
			substep := 1.
			step := step + 1.
			step > 12
				ifTrue: [ step := 1 ] ]
]

{ #category : #'accessing-forms' }
RMapRenderer >> underlineLabelFormsFor: anRMapVertex [
	| label font lines form |
	label := anRMapVertex label.
	font := TextStyle default defaultFont.
	lines := (label substrings: String cr)
		ifEmpty: [ Array with: anRMapVertex position printString ].
	form := Form
		extent:
			((lines inject: 0 into: [ :max :each | max max: (font widthOfString: each) ]) + 2)
				@ (lines size * font height * 2 + 2)
		depth: 32.
	form getCanvas
		in: [ :canvas | 
			canvas fillColor: Color transparent.
			lines
				keysAndValuesDo: [ :index :line | 
					canvas
						drawString: line
						at: ((form width - (font widthOfString: line)) // 2) @ ((index - 1) * font height + 1)
						font: font
						color: Color black ].
			canvas
				line: 0 @ (lines size * font height + 1)
				to: form width @ (lines size * font height + 1)
				width: 2
				color:
					(label first = $E
						ifTrue: [ Color blue ]
						ifFalse: [ label first = $D
								ifTrue: [ Color green ]
								ifFalse: [ Color red ] ]) ].
	^ Array with: form
]
