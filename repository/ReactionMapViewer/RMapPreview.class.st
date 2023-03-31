Class {
	#name : #RMapPreview,
	#superclass : #SpPresenter,
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

	<script:
	'RMapPreview new openDialogWithSpec title: ''Vertex Preview'''>
	<spec>
	^ SpBoxLayout newVertical
		  add: #nameLabel expand: false;
		  add: #componentsLabel expand: false;
		  add: #vertexList;
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
RMapPreview >> initializePresenters [

	nameLabel := self newLabel.
	componentsLabel := self newLabel.
	vertexList := self newList
		              display: [ :vertex | 
			              vertex label , ' '
			              , vertex kJpermolAboveBaselineString ];
		              displayIcon: [ :vertex | 
			              vertex asFormExtent: 100 @ 100 ];
		              whenSelectionChangedDo: [ 
			              vertexList selectedItem ifNotNil: #openJmol ];
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
	(rmap isNil or: [ (rmap includesKey: 'meta') not ]) ifTrue: [ 
		self nameLabel label: '-'.
		self componentsLabel label: '-'.
		self vertexList
			items: Array new;
			unselectAll.
		^ self ].
	meta := rmap at: 'meta'.
	self nameLabel label: (meta at: 'name' ifAbsent: [ '' ]).
	self componentsLabel label:
		(meta at: 'numEQ' ifAbsent: [ 0 ]) asString , ' EQs, '
		, (meta at: 'numTS' ifAbsent: [ 0 ]) asString , ' TSs, '
		, (meta at: 'numDC' ifAbsent: [ 0 ]) asString , ' DCs'.
	vertices := (meta at: 'stableEQs') collect: [ :json | 
		            RMapVertex fromJson: json ].
	vertices do: [ :vertex | 
		vertex baselineEnergy: vertices first energy ].
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
