event handling
mouseDown: aMouseEvent
	aMouseEvent yellowButtonPressed
		ifTrue: [ ^ self yellowButtonActivity: aMouseEvent shiftPressed ].
	super mouseDown: aMouseEvent