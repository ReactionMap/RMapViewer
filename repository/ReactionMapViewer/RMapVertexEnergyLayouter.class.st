Class {
	#name : #RMapVertexEnergyLayouter,
	#superclass : #RMapVertexLayouter,
	#instVars : [
		'min',
		'max',
		'denominator'
	],
	#category : #'ReactionMapViewer-Layouters'
}

{ #category : #accessing }
RMapVertexEnergyLayouter >> dcX [
	^ 0.2
]

{ #category : #accessing }
RMapVertexEnergyLayouter >> denominator [
	^ denominator ifNil: [ denominator := self max - self min ]
]

{ #category : #drawing }
RMapVertexEnergyLayouter >> drawLegendsOn: aCanvas [
	| font |
	font := TextStyle default defaultFont.
	aCanvas
		drawString: 'DC'
			at:
			(self normalizedPositionToPosition: self dcX @ 0.0)
				- (((font widthOfString: 'DC') // 2) @ (font height * 2));
		line: (self normalizedPositionToPosition: self dcX @ 0.1)
			to: (self normalizedPositionToPosition: self dcX @ 1.0)
			width: 1
			color: (Color gray: 0.9);
		drawString: 'EQ'
			at:
			(self normalizedPositionToPosition: self eqX @ 0.0)
				- (((font widthOfString: 'EQ') // 2) @ (font height * 2));
		line: (self normalizedPositionToPosition: self eqX @ 0.1)
			to: (self normalizedPositionToPosition: self eqX @ 1.0)
			width: 1
			color: (Color gray: 0.9);
		drawString: 'TS'
			at:
			(self normalizedPositionToPosition: self tsX @ 0.0)
				- (((font widthOfString: 'TS') // 2) @ (font height * 2));
		line: (self normalizedPositionToPosition: self tsX @ 0.1)
			to: (self normalizedPositionToPosition: self tsX @ 1.0)
			width: 1
			color: (Color gray: 0.9)
]

{ #category : #accessing }
RMapVertexEnergyLayouter >> eqX [
	^ 0.5
]

{ #category : #accessing }
RMapVertexEnergyLayouter >> max [
	^ max
		ifNil: [ max := (rmap argmaxVertex: [ :vertex | vertex energy ]) energy ]
]

{ #category : #accessing }
RMapVertexEnergyLayouter >> min [
	^ min
		ifNil: [ min := (rmap argminVertex: [ :vertex | vertex energy ]) energy ]
]

{ #category : #accessing }
RMapVertexEnergyLayouter >> normalizedPositionFor: anRMapVertex [
	| char |
	char := anRMapVertex label first.
	^ (char = $E
		ifTrue: [ self eqX ]
		ifFalse: [ char = $T
				ifTrue: [ self tsX ]
				ifFalse: [ self dcX ] ])
		@ ((anRMapVertex energy - self min) / self denominator * 0.8 + 0.2)
]

{ #category : #accessing }
RMapVertexEnergyLayouter >> tsX [
	^ 0.8
]

{ #category : #accessing }
RMapVertexEnergyLayouter >> update [
	min := nil.
	max := nil.
	denominator := nil.
	super update
]
