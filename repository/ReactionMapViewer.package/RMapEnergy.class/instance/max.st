accessing
max
	^ max ifNil: [ max := (rmap argmaxVertex: [:vertex | vertex energy]) energy]