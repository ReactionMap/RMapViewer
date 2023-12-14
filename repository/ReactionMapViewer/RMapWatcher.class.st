Class {
	#name : #RMapWatcher,
	#superclass : #SpPresenter,
	#instVars : [
		'directoryPathField',
		'changeDirectoryButton',
		'intervalField',
		'checkNowButton',
		'closeButton',
		'watchProcess',
		'rmap'
	],
	#category : #'ReactionMapViewer-Monitor'
}

{ #category : #operations }
RMapWatcher >> changeDirectoryPath [

	(UIManager default
		 chooseDirectory: 'Choose a directory to watch'
		 from: FileLocator home) ifNotNil: [ :newPath |
		newPath isDirectory ifTrue: [
			directoryPathField text: newPath pathString ] ]
]

{ #category : #operations }
RMapWatcher >> checkNow [

	UIManager default confirm:
		'A new map is available. Close the current one?'
]

{ #category : #initialization }
RMapWatcher >> initializePresenters [

	super initializePresenters.
	directoryPathField := self newTextInput
		                      disable;
		                      yourself.
	changeDirectoryButton := self newButton
		                         label: '...';
		                         action: [ self changeDirectoryPath ];
		                         yourself.
	intervalField := self newNumberInput
		                 beInteger;
		                 yourself.
	checkNowButton := self newButton
		                  label: 'Check Now';
		                  action: [ self checkNow ];
		                  yourself.
	closeButton := self newButton
		               label: 'OK';
		               action: [ self window ifNotNil: #close ];
		               yourself
]
