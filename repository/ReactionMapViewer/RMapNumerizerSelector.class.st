Class {
	#name : #RMapNumerizerSelector,
	#superclass : #RMapSelector,
	#instVars : [
		'value'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #accessing }
RMapNumerizerSelector >> index: anInteger [
	super index: anInteger.
	value transitionRevolvingTo: (list at: index)
]

{ #category : #'initialize-release' }
RMapNumerizerSelector >> initialize [
	super initialize.
	value := nil
]

{ #category : #accessing }
RMapNumerizerSelector >> value [
	^ value ifNil: [ value := super value ]
]

{ #category : #accessing }
RMapNumerizerSelector >> value: anRMapNumerizer [
	value := anRMapNumerizer
]
