Class {
	#name : #RMapMoleculeScratcherMorph,
	#superclass : #JunMoleculeScratcherMorph,
	#instVars : [
		'defaultAtomClass'
	],
	#category : 'ReactionMapViewer-Morphs'
}

{ #category : #accessing }
RMapMoleculeScratcherMorph >> defaultAtomClass [
	^ defaultAtomClass
]

{ #category : #accessing }
RMapMoleculeScratcherMorph >> defaultAtomClass: aJunAtomClass [
	defaultAtomClass := aJunAtomClass
]

{ #category : #'initialize-release' }
RMapMoleculeScratcherMorph >> initialize [
	super initialize.
	defaultAtomClass := JunCarbon
]
