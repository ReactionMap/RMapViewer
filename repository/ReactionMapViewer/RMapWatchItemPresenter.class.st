Class {
	#name : #RMapWatchItemPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'nameField',
		'directoryField',
		'chooseDirectoryButton',
		'intervalField',
		'typeDropList'
	],
	#classVars : [
		'PauseIcon'
	],
	#category : #'ReactionMapViewer-Watcher'
}

{ #category : #layout }
RMapWatchItemPresenter class >> defaultLayout [

	^ SpGridLayout new
		  rowSpacing: 0;
		  beRowNotHomogeneous;
		  beColumnNotHomogeneous;
		  column: 1 withConstraints: [ :c | c vAlignCenter ];
		  column: 2 withConstraints: [ :c | c expand: true ];
		  column: 3 withConstraints: [ :c | c vAlignCenter ];
		  add: 'Name ' at: 1 @ 1;
		  add:
			  (SpBoxLayout newVertical
				   add: #nameField
				   height: self inputTextHeight)
		  at: 2 @ 1;
		  add: 'Type ' at: 1 @ 2;
		  add: (SpBoxLayout newVertical
				   add: #typeDropList
				   height: self inputTextHeight)
		  at: 2 @ 2;
		  add: 'Directory ' at: 1 @ 3;
		  add: (SpBoxLayout newVertical
				   add: #directoryField
				   height: self inputTextHeight)
		  at: 2 @ 3;
		  add:
			  (SpBoxLayout newHorizontal add: #chooseDirectoryButton width: 24)
		  at: 3 @ 3;
		  add: 'Interval' at: 1 @ 4;
		  add: (SpBoxLayout newVertical
				   add: #intervalField
				   height: self inputTextHeight)
		  at: 2 @ 4;
		  add: ' hours' at: 3 @ 4;
		  yourself
]

{ #category : #utilities }
RMapWatchItemPresenter class >> openDialog [

	^ (self on: RMapWatchItem new) openDialog
]

{ #category : #operations }
RMapWatchItemPresenter >> changeDirectory [

	(UIManager default
		 chooseDirectory: 'Choose a directory to monitor'
		 from: FileLocator home) ifNotNil: [ :ref |
		self model ifNotNil: [ :item |
			item directory: ref.
			directoryField text: ref pathString.
			nameField text ifEmpty: [ nameField text: ref basename ] ] ]
]

{ #category : #icons }
RMapWatchItemPresenter >> directoryIcon [

	^ Smalltalk ui iconNamed: 'open'
]

{ #category : #initialization }
RMapWatchItemPresenter >> initializePresenters [

	super initializePresenters.
	nameField := self newTextInput
		             text: '';
		             whenTextChangedDo: [ :newText |
			             self model ifNotNil: [ :item | item name: newText ] ];
		             yourself.
	directoryField := self newTextInput
		                  beNotEditable;
		                  text: '';
		                  yourself.
	chooseDirectoryButton := self newButton
		                         icon: self directoryIcon;
		                         action: [ self changeDirectory ];
		                         yourself.
	intervalField := self newNumberInput
		                 whenNumberChangedDo: [ :newNumber |
			                 self model ifNotNil: [ :item |
					                 item interval: newNumber hour ] ];
		                 yourself.
	typeDropList := self newDropList
		                items: {
				                RMapWatchItem trajectory.
				                RMapWatchItem grrmDigest.
				                RMapWatchItem grrmFull };
		                whenSelectedItemChangedDo: [
			                self model ifNotNil: [ :item |
					                item type: typeDropList selectedItem ] ];
		                yourself
]

{ #category : #initialization }
RMapWatchItemPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter initialExtent: 450 @ 250
]

{ #category : #accessing }
RMapWatchItemPresenter >> modelChanged [

	self model ifNotNil: [ :watchItem |
		nameField text: (watchItem name ifNil: [ '' ]).
		directoryField text:
			(watchItem directory ifNotNil: #pathString ifNil: [ '' ]).
		intervalField number:
			(watchItem interval ifNotNil: #asHours ifNil: [ 1.0 ]).
		typeDropList selectItem: (watchItem type ifNil: [ RMapWatchItem grrmDigest ]) ]
]

{ #category : #accessing }
RMapWatchItemPresenter >> title [

	^ 'Watch setup'
]

{ #category : #accessing }
RMapWatchItemPresenter >> watchItem [

	^ self model
]
