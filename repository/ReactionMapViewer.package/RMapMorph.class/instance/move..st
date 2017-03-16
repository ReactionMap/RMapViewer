viewer functions
move: aPoint
	self viewOffset: aPoint negated / self extent / (viewScale @ viewScale negated) + viewOffset