event handling
mouseDown: anEvent
	hoverVertex
		ifNotNil: [ 
			(self addVertexMenu: (UIManager default newMenuIn: self for: self))
				ifNotNilDo: [ :menu | 
					menu setInvokingView: self.
					menu popUpEvent: self activeHand lastEvent in: self world ] ]