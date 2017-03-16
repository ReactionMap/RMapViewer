event handling
doubleClick: event
	hoverVertex
		ifNotNil: [ 
			self rotateSelection: hoverVertex]