event handling
click: anEvent
	| x y |
	x := (anEvent position x - self left - 5.0) / (self width - 10.0).
	y := (self bottom - anEvent position y - 5) / (self height - 10.0).
	(rmapMorph respondsTo: #move:)
		ifTrue: [ rmapMorph viewOffset: x @ y ]