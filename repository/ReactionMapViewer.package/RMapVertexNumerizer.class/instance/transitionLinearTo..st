accessing
transitionLinearTo: anRMapVertexNumerizer
	anRMapVertexNumerizer reset.
	rmap
		perform: setter
		with:
			(RMapLinearTransitionNumerizer
				on: rmap
				from: self
				to: anRMapVertexNumerizer
				setter: setter)