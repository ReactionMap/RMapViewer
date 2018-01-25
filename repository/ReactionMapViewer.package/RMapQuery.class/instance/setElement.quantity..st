menus
setElement: elementString quantity: quantityString
	| assocs |
	assocs := self compositionTable listItems.
	assocs := (assocs reject: [ :assoc | assoc key = elementString ]) copyWith: elementString -> quantityString.
	self compositionTable items: assocs