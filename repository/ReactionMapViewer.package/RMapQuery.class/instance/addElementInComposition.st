menus
addElementInComposition
	| element quantity |
	element := JunPeriodicTableMorph chooseAnAtomClass symbol.
	quantity := UIManager default chooseFrom: (0 to: 99) asArray title: 'quantity'.
	quantity ifNotNil: [ self setElement: element quantity: (quantity - 1) asString ]