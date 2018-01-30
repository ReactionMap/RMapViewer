initialization
initializeWidgets
	urlField := self newTextInput
		text: 'http://localhost:1701/';
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