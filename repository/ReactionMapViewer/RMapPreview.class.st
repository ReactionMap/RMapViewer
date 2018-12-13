Class {
	#name : #RMapPreview,
	#superclass : #ComposablePresenter,
	#instVars : [
		'nameLabel',
		'componentsLabel',
		'vertexList',
		'rmap'
	],
	#category : #'ReactionMapViewer-Client'
}

{ #category : #specs }
RMapPreview class >> defaultSpec [
	<script: 'RMapPreview new openDialogWithSpec title: ''Vertex Preview'''>
	<spec>
	^ SpecLayout composed
		newColumn: [ :c | 
					c
						add: #nameLabel height: 20;
						add: #componentsLabel height: 20;
						add: #vertexList;
						yourself ];
		yourself
]

{ #category : #accessing }
RMapPreview >> componentsLabel [
	^ componentsLabel
]

{ #category : #accessing }
RMapPreview >> componentsLabel: anObject [
	componentsLabel := anObject
]

{ #category : #initialization }
RMapPreview >> initializeWidgets [
	nameLabel := self newLabel.
	componentsLabel := self newLabel.
	vertexList := self newIconList
		displayBlock: [ :vertex | vertex label , ' ' , vertex kJpermolAboveBaselineString ];
		icons: [ :vertex | vertex asFormExtent: 100 @ 100 ];
		whenSelectedItemChanged: [ :vertex | vertex ifNotNil: #openJmol];
		yourself.
	self updateRMap
]

{ #category : #accessing }
RMapPreview >> nameLabel [
	^ nameLabel
]

{ #category : #accessing }
RMapPreview >> nameLabel: anObject [
	nameLabel := anObject
]

{ #category : #accessing }
RMapPreview >> rmap [
	^ rmap
]

{ #category : #accessing }
RMapPreview >> rmap: aDictionary [
	rmap := aDictionary.
	self updateRMap
]

{ #category : #private }
RMapPreview >> updateRMap [
	| meta vertices |
	(rmap isNil or: [ (rmap includesKey: 'meta') not ])
		ifTrue: [ 
			self nameLabel label: '-'.
			self componentsLabel label: '-'.
			self vertexList
				items: Array new;
				resetSelection.
			^ self ].
	meta := rmap at: 'meta'.
	self nameLabel label: (meta at: 'name' ifAbsent: [ '' ]).
	self componentsLabel
		label:
			(meta at: 'numEQ' ifAbsent: [ 0 ]) asString , ' EQs, ' , (meta at: 'numTS' ifAbsent: [ 0 ]) asString , ' TSs, '
				, (meta at: 'numDC' ifAbsent: [ 0 ]) asString , ' DCs'.
	vertices := (meta at: 'stableEQs') collect: [ :json | RMapVertex fromJson: json ].
	vertices do: [ :vertex | vertex baselineEnergy: vertices first energy ].
	self vertexList
		items: vertices;
		resetSelection
]

{ #category : #accessing }
RMapPreview >> vertexList [
	^ vertexList
]

{ #category : #accessing }
RMapPreview >> vertexList: anObject [
	vertexList := anObject
]
