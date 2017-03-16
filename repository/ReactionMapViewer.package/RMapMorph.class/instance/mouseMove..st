event handling
mouseMove: event
	event isMove ifTrue: [
		self move: event endPoint - event startPoint]