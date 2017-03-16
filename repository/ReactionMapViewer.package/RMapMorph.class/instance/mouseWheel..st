event handling
mouseWheel: aMouseEvent
	aMouseEvent isUp
		ifTrue: [ 
			aMouseEvent wasHandled: true.
			self zoomOut ].
	aMouseEvent isDown
		ifTrue: [ self zoomIn ].
	super mouseWheel: aMouseEvent