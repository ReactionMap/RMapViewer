accessing
transitionRevolvingTo: anRMapVertexNumerizer
	anRMapVertexNumerizer reset.
	rmap
		perform: setter
		with:
			(RMapRevolvingTransitionNumerizer
				on: rmap
				from: self
				to: anRMapVertexNumerizer
				setter: setter)