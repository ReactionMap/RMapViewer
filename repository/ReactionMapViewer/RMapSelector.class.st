Class {
	#name : #RMapSelector,
	#superclass : #Model,
	#instVars : [
		'list',
		'index',
		'getMenuBlock'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #adding }
RMapSelector >> add: anRMapNumerizer [
	list := list copyWith: anRMapNumerizer.
	^ anRMapNumerizer
]

{ #category : #converting }
RMapSelector >> asDropListMorph [
	^ DropListMorph on: self list: #list selected: #index changeSelected: #index:
]

{ #category : #converting }
RMapSelector >> asListMorph [
	^ PluggableListMorph on: self list: #list selected: #index changeSelected: #index: menu: #getMenu: 
]

{ #category : #converting }
RMapSelector >> asMorphListMorph [
	^ PluggableMorphListMorph on: self list: #list selected: #index changeSelected: #index: menu: #getMenu: 
]

{ #category : #accessing }
RMapSelector >> getMenu: aMenu [
	getMenuBlock ifNotNil: [ getMenuBlock value: aMenu ].
	^ aMenu
]

{ #category : #accessing }
RMapSelector >> getMenuBlock: aBlock [
	getMenuBlock := aBlock
]

{ #category : #accessing }
RMapSelector >> index [
	^ index
]

{ #category : #accessing }
RMapSelector >> index: anInteger [
	index := anInteger.
	self changed: #index.
	self changed
]

{ #category : #'initialize-release' }
RMapSelector >> initialize [
	super initialize.
	list := Array new.
	index := 1
]

{ #category : #accessing }
RMapSelector >> list [
	^ list
]

{ #category : #accessing }
RMapSelector >> list: anArrayOfRMapNumerator [
	list := anArrayOfRMapNumerator.
	self changed: #list
]

{ #category : #accessing }
RMapSelector >> value [
	^ list at: index ifAbsent: [ ]
]
