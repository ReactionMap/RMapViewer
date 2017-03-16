event handling
handleMouseUp: aMouseEvent
	dragSource
		ifNotNil: [ 
			dropTarget ifNotNil: [ self atomAt: (atoms indexOf: dragSource) put: dropTarget ].
			dragSource := nil.
			dropTarget := nil.
			aMouseEvent wasHandled: true.
			^ self changed ].
	^ super handleMouseUp: aMouseEvent