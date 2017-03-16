accessing-cursor
atomAtCursor
	| atom distance line |
	atom := nil.
	distance := 0.3.
	line := Jun3dLine from: projection eyePoint to: self cursor3dPoint.
	1 to: molecule size do: [ :index | 
		| a d |
		a := molecule at: index.
		d := line distanceFromPoint: a position.
		d < distance
			ifTrue: [ 
				distance := d.
				atom := a ] ].
	^ atom