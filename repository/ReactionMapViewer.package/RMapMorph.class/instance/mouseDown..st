event handling
mouseDown: event
	self takeKeyboardFocus.
	event yellowButtonPressed
		ifTrue: [ 
			(self addVertexMenu: (UIManager default newMenuIn: self for: self))
				ifNotNilDo: [ :menu | 
					menu setInvokingView: self.
					menu popUpEvent: self activeHand lastEvent in: self world ] ]
		ifFalse: [ event hand waitForClicksOrDrag: self event: event ]