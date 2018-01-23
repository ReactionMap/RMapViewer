initialization
initializeWidgets
	nameField := self newTextInput.
	nameField removeEntryCompletion.
	nameField ghostText: 'Name of reaction map'.
	nameField autoAccept: true.
	commandField := self newTextInput.
	commandField removeEntryCompletion.
	commandField ghostText: 'grrm command'.
	commandField autoAccept: true.
	methodField := self newTextInput.
	methodField removeEntryCompletion.
	methodField ghostText: 'method'.
	methodField autoAccept: true.
	basisField := self newTextInput.
	basisField removeEntryCompletion.
	basisField ghostText: 'basis'.
	basisField autoAccept: true.
	compositionTable := self newMultiColumnList.
	compositionTable
		displayBlock: [ :assoc | 
			{(assoc key).
			(assoc value)} ].
	compositionTable
		sortingBlock: [ :less :more | 
					(#('C' 'H' 'O') includes: less key)
						ifTrue: [ 
							(#('C' 'H' 'O') includes: more key)
								ifTrue: [ less key <= more key ]
								ifFalse: [ true ] ]
						ifFalse: [ 
							(#('C' 'H' 'O') includes: more key)
								ifTrue: [ false ]
								ifFalse: [ less key <= more key ] ] ];
		items:
				{('C' -> '').
					('H' -> '').
					('O' -> '')};
		menu: [ :m :s | self compositionMenu: m shifted: s ]