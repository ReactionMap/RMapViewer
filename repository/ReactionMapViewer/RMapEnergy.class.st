Class {
	#name : #RMapEnergy,
	#superclass : #RMapVertexNumerizer,
	#instVars : [
		'min',
		'max',
		'denominator'
	],
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapEnergy >> denominator [
	^ denominator ifNil: [ denominator := self max - self min ]
]

{ #category : #accessing }
RMapEnergy >> max [
	^ max ifNil: [ max := (rmap argmaxVertex: [:vertex | vertex energy]) energy]
]

{ #category : #accessing }
RMapEnergy >> min [
	^ min ifNil: [ min := (rmap argminVertex: [:vertex | vertex energy]) energy]
]

{ #category : #accessing }
RMapEnergy >> name [
	^ 'Energy'
]

{ #category : #accessing }
RMapEnergy >> update [
	min := nil.
	max := nil.
	denominator := nil
]

{ #category : #accessing }
RMapEnergy >> value: anRMapVertex [
	^ anRMapVertex energy - self min / self denominator
]
