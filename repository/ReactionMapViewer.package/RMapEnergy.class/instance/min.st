accessing
min
	^ min ifNil: [ min := (rmap argminVertex: [:vertex | vertex energy]) energy]