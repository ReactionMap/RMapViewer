Class {
	#name : #RMapWatcher,
	#superclass : #SpPresenter,
	#instVars : [
		'watchList',
		'addButton',
		'removeButton',
		'editButton',
		'pauseButton',
		'fetchButton',
		'openButton',
		'watchProcess'
	],
	#classVars : [
		'Current'
	],
	#category : #'ReactionMapViewer-Watcher'
}

{ #category : #layout }
RMapWatcher class >> defaultLayout [

	<script: 'RMapWatcher new open'>
	| buttonSize |
	buttonSize := 22.
	^ SpBoxLayout newVertical
		  add: #watchList;
		  add: (SpBoxLayout newHorizontal
				   add: #addButton width: buttonSize;
				   add: #removeButton width: buttonSize;
				   add: #editButton width: buttonSize;
				   add: #pauseButton width: buttonSize;
				   add: #fetchButton width: buttonSize;
				   add: #openButton width: buttonSize * 2;
				   yourself)
		  height: buttonSize;
		  yourself
]

{ #category : #'instance creation' }
RMapWatcher class >> flushCurrent [

	<script: 'RMapWatcher flushCurrent'>
	Current := nil
]

{ #category : #'instance creation' }
RMapWatcher class >> open [

	<script: 'RMapWatcher open'>
	(Current ifNil: [ Current := self new ]) window
		ifNil: [ Current open ]
		ifNotNil: [ :window |
			window isOpen
				ifTrue: [
				window isMinimized ifTrue: [ window adapter widget collapseBoxHit ] ]
				ifFalse: [ window open ] ].
	^ Current
]

{ #category : #icons }
RMapWatcher >> addIcon [

	^ Smalltalk ui iconNamed: 'add'
]

{ #category : #operations }
RMapWatcher >> addItem [

	RMapWatchItemPresenter openDialog okAction: [ :dialog |
		dialog presenter watchItem ifNotNil: [ :watchItem |
			watchList
				items: (watchList items copyWith: watchItem);
				selectIndex: watchList items size ] ]
]

{ #category : #icons }
RMapWatcher >> editIcon [

	^ Smalltalk ui iconNamed: 'configuration'
]

{ #category : #operations }
RMapWatcher >> editItem [

	watchList selectedItem ifNotNil: [ :watchItem |
		(RMapWatchItemPresenter on: watchItem copy) openDialog okAction: [
			:dialog |
			| items index |
			items := watchList items.
			index := watchList items indexOf: watchItem.
			index > 0 ifTrue: [ items at: index put: dialog watchItem ].
			watchList
				items: items;
				selectIndex: index ] ]
]

{ #category : #icons }
RMapWatcher >> fetchIcon [

	^ Smalltalk ui iconNamed: 'smallUpdate'
]

{ #category : #operations }
RMapWatcher >> fetchItem [

	watchList selectedItem ifNotNil: #fetch.
	self updateWatchList
]

{ #category : #initialization }
RMapWatcher >> initializePresenters [

	super initializePresenters.
	watchList := self newTable
		             beSingleSelection;
		             addColumn:
			             ((SpImageTableColumn title: '' evaluated: #icon)
				              width: 20;
				              yourself);
		             addColumn:
		             (SpStringTableColumn title: 'name' evaluated: #name);
		             addColumn:
			             ((SpStringTableColumn
				               title: 'last fetch'
				               evaluated: #lastFetchString)
				              width: 140;
				              yourself);
		             addColumn:
			             ((SpStringTableColumn
				               title: 'next fetch'
				               evaluated: #nextFetchString)
				              width: 140;
				              yourself);
		             addColumn:
			             ((SpStringTableColumn title: 'EQs' evaluated: #numEQs)
				              width: 60;
				              yourself);
		             addColumn:
			             ((SpStringTableColumn title: 'TSs' evaluated: #numTSs)
				              width: 60;
				              yourself);
		             whenSelectionChangedDo: [ self updateButtons ];
		             yourself.
	addButton := self newButton
		             icon: self addIcon;
		             action: [ self addItem ];
		             yourself.
	removeButton := self newButton
		                disable;
		                icon: self removeIcon;
		                action: [ self removeItem ];
		                yourself.
	editButton := self newButton
		              disable;
		              icon: self editIcon;
		              action: [ self editItem ];
		              yourself.
	pauseButton := self newButton
		               disable;
		               icon: self pauseIcon;
		               action: [ self pauseItem ];
		               yourself.
	fetchButton := self newButton
		               disable;
		               icon: self fetchIcon;
		               action: [ self fetchItem ];
		               yourself.
	openButton := self newButton
		              disable;
		              icon: self openIcon;
		              action: [ self openRMap ];
		              yourself
]

{ #category : #initialization }
RMapWatcher >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter initialExtent: 600 @ 200.
	aSpWindowPresenter
		whenClosedDo: [ self stopWatching ];
		whenOpenedDo: [ self startWatching ]
]

{ #category : #testing }
RMapWatcher >> isWatching [

	^ watchProcess notNil
]

{ #category : #icons }
RMapWatcher >> openIcon [

	^ Smalltalk ui iconNamed: 'window'
]

{ #category : #operations }
RMapWatcher >> openRMap [

	watchList selectedItem ifNotNil: [ :watchItem |
		watchItem rmap ifNotNil: [ :rmap |
			rmap world ifNil: [ rmap openFullInWorld ] ] ]
]

{ #category : #icons }
RMapWatcher >> pauseIcon [

	| form |
	form := Form extent: 16 @ 16 depth: 32.
	form getCanvas
		fillColor: Color transparent;
		fillRectangle: (5 @ 2 corner: 8 @ 14) color: Color darkGray;
		fillRectangle: (10 @ 2 corner: 13 @ 14) color: Color darkGray;
		flush.
	^ form
]

{ #category : #operations }
RMapWatcher >> pauseItem [

	watchList selectedItem ifNotNil: #pause.
	self updateWatchList
]

{ #category : #icons }
RMapWatcher >> removeIcon [

	^ Smalltalk ui iconNamed: 'remove'
]

{ #category : #operations }
RMapWatcher >> removeItem [

	watchList selectedItem ifNotNil: [ :item |
		item delete.
		watchList items: (watchList item copyWithout: item) ]
]

{ #category : #operations }
RMapWatcher >> startWatching [

	watchProcess ifNil: [
		watchProcess := [
		                [
		                1 second wait.
		                self watch ] repeat ] forkAt:
			                Processor userBackgroundPriority ]
]

{ #category : #operations }
RMapWatcher >> stopWatching [

	watchProcess ifNotNil: [ :p |
		watchProcess := nil.
		p terminate ]
]

{ #category : #accessing }
RMapWatcher >> title [

	^ 'RMap Watcher'
]

{ #category : #updating }
RMapWatcher >> updateButtons [

	| enable |
	enable := watchList selectedItem notNil.
	{
		removeButton.
		editButton.
		pauseButton.
		fetchButton.
		openButton } do: [ :button | button enabled: enable ]
]

{ #category : #updating }
RMapWatcher >> updateWatchList [

	watchList refresh
]

{ #category : #updating }
RMapWatcher >> watch [

	watchList items do: [ :watchItem | watchItem watch ].
	watchList refresh
]
