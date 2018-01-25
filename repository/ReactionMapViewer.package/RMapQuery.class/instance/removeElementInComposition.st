menus
removeElementInComposition
	| element |
	element := self compositionTable selectedItem key.
	(#('C' 'H' 'O') includes: element)
		ifTrue: [ self setElement: element quantity: '' ]
		ifFalse: [ self compositionTable items: (self compositionTable listItems reject: [ :assoc | assoc key = element ]) ]