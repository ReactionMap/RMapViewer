accessing
index: anInteger
	super index: anInteger.
	value transitionRevolvingTo: (list at: index)