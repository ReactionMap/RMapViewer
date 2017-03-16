event handling
handleMouseDown: aMouseEvent
	self atomAtCursor
		ifNotNil: [ :atom | 
			(self activeAtomsIncludes: atom)
				ifTrue: [ 
					dragSource := atom.
					aMouseEvent wasHandled: true.
					self changed.
					^ self ] ].
	^ super handleMouseDown: aMouseEvent