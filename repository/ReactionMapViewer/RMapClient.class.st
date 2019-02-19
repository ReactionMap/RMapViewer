Class {
	#name : #RMapClient,
	#superclass : #ComposablePresenter,
	#instVars : [
		'urlField',
		'queryModel',
		'searchButton',
		'rmapList',
		'rmapModel',
		'openButton',
		'rmapMorph'
	],
	#category : #'ReactionMapViewer-Client'
}

{ #category : #specs }
RMapClient class >> defaultSpec [
	<script: 'RMapClient new openWithSpec title: ''RMapClient'''>
	<spec>
	^ SpecLayout composed
		newRow: [ :row | 
					row
						newColumn: [ :c | 
									c
										add: #urlField height: 20;
										add: #queryModel;
										add: #searchButton height: 25;
										yourself ]
							width: 300;
						newColumn: [ :c | 
									c
										add: #rmapList;
										yourself ]
							width: 300;
						newColumn: [ :c | 
									c
										add: #rmapModel;
										add: #openButton height: 25;
										yourself ] ];
		yourself
]

{ #category : #'instance creation' }
RMapClient class >> on: anRMapMorph [
	^ self new
		rmapMorph: anRMapMorph;
		yourself
]

{ #category : #operations }
RMapClient >> getRMap: aDictionary [
	| url client response |
	aDictionary ifNil: [ ^ nil ].
	url := urlField text asString trim asZnUrl / 'api' / 'get'.
	client := ZnClient new
		beOneShot;
		url: url;
		yourself.
	client queryAt: '_id' put: (aDictionary at: '_id' ifAbsent: [ ^ nil ]).
	client get.
	response := client response.
	^ response isSuccess
		ifTrue: [ NeoJSONReader fromString: response entity string ]
		ifFalse: [ nil ]
]

{ #category : #initialization }
RMapClient >> initialExtent [
	^ 1000@400
]

{ #category : #initialization }
RMapClient >> initializePresenter [
	rmapList whenSelectedItemChanged: [ :rmap | self selectRMap: rmap ]
]

{ #category : #initialization }
RMapClient >> initializeWidgets [
	urlField := self newTextInput
		text: 'http://133.167.127.202/rmapserver/';
		removeEntryCompletion;
		ghostText: 'Server URL';
		autoAccept: true;
		yourself.
	queryModel := self newQueryModel.
	searchButton := self newButton
		label: 'Search';
		action: [ self search ];
		yourself.
	rmapList := self newList
		displayBlock: [ :json | (json at: 'meta') at: 'name' ];
		yourself.
	rmapModel := self newPreviewModel
		rmap: nil;
		yourself.
	openButton := self newButton
		label: 'Open';
		action: [ self openRMap ];
		disable;
		yourself
]

{ #category : #widgets }
RMapClient >> newPreviewModel [
	^ self instantiate: RMapPreview new
]

{ #category : #widgets }
RMapClient >> newQueryModel [
	^ self instantiate: RMapQuery new
]

{ #category : #accessing }
RMapClient >> openButton [
	^ openButton
]

{ #category : #accessing }
RMapClient >> openButton: anObject [
	openButton := anObject
]

{ #category : #operations }
RMapClient >> openRMap [
	| rmap |
	rmap := self getRMap: rmapList selectedItem.
	self delete.
	rmapMorph
		ifNil: [ rmapMorph := RMapMorph fromDictionary: rmap.
			^ rmapMorph openFullInWorld ].
	rmapMorph
		load: rmap;
		openFullInWorld
]

{ #category : #accessing }
RMapClient >> queryModel [
	^ queryModel
]

{ #category : #accessing }
RMapClient >> queryModel: anObject [
	queryModel := anObject
]

{ #category : #accessing }
RMapClient >> rmapList [
	^ rmapList
]

{ #category : #accessing }
RMapClient >> rmapList: anObject [
	rmapList := anObject
]

{ #category : #accessing }
RMapClient >> rmapModel [
	^ rmapModel
]

{ #category : #accessing }
RMapClient >> rmapModel: anObject [
	rmapModel := anObject
]

{ #category : #accessing }
RMapClient >> rmapMorph: anRMapMorph [
	rmapMorph := anRMapMorph
]

{ #category : #operations }
RMapClient >> search [
	| url query client response |
	url := urlField text asString trim asZnUrl / 'api' / 'search'.
	query := self queryModel query.
	client := ZnClient new
		beOneShot;
		url: url;
		yourself.
	query keysAndValuesDo: [ :key :value | client queryAt: key put: value ].
	client get.
	response := client response.
	response isSuccess
		ifFalse: [ 
			| status |
			status := response status.
			^ UIManager inform: status code printString , ' ' , status reason ].
	rmapList
		items: (NeoJSONReader fromString: response entity string);
		resetSelection
]

{ #category : #accessing }
RMapClient >> searchButton [
	^ searchButton
]

{ #category : #accessing }
RMapClient >> searchButton: anObject [
	searchButton := anObject
]

{ #category : #operations }
RMapClient >> selectRMap: aDictionary [
	openButton enabled: aDictionary notNil.
	rmapModel rmap: aDictionary
]

{ #category : #accessing }
RMapClient >> urlField [
	^ urlField
]

{ #category : #accessing }
RMapClient >> urlField: anObject [
	urlField := anObject
]
