event handling
handleMouseMove: aMouseEvent
	aMouseEvent redButtonPressed
		ifTrue: [ 
			dragSource
				ifNotNil: [ 
					| atom |
					atom := self atomAtCursor.
					(self activeAtomsIncludes: atom)
						ifTrue: [ atom := nil ].
					dropTarget := self atomAtCursor.
					aMouseEvent wasHandled: true.
					self changed.
					^ self ] ].
	^ super handleMouseMove: aMouseEvent