menus
compositionMenu: aMenu shifted: aBoolean
	self compositionTable selectedItem
		ifNil: [ aMenu add: 'add' target: self selector: #addElementInComposition ]
		ifNotNil: [ 
			aMenu
				add: 'set quantity' target: self selector: #setQuantityInComposition;
				add: 'remove' target: self selector: #removeElementInComposition ].
	^ aMenu