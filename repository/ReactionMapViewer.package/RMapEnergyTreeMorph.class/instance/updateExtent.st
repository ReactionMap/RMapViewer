updating
updateExtent
	self extent: (self hops * self bandWidth max: owner width) @ (owner height + 16).
	owner
		ifNotNil: [ 
			owner owner
				ifNotNil: [ :scrollPane | 
					scrollPane hSetScrollDelta.
					scrollPane hScrollBar color: World theme windowColor.]]