layouting
arrange: nodes
	| scoreBlock bestPosition bestScore x0 y0 dx dy |
	scoreBlock := [ 
	(nodes
		collect: [ :n | 
			n == self
				ifTrue: [ Float fmax ]
				ifFalse: [ n position dist: position ] ]) min ].
	bestPosition := position.
	bestScore := scoreBlock value.
	x0 := eq1 position x min: eq2 position x.
	y0 := eq1 position y min: eq2 position y.
	dx := (eq1 position x max: eq2 position x) - x0 + eq1 gap.
	dy := (eq1 position y max: eq2 position y) - y0 + eq1 gap.
	x0 := x0 - (eq1 gap * 0.5).
	y0 := y0 - (eq1 gap * 0.5).
	50
		timesRepeat: [ 
			| score |
			position := dx * self random + x0 , (dy * self random + y0).
			score := scoreBlock value.
			score > bestScore
				ifTrue: [ 
					bestScore := score.
					bestPosition := position ] ].
	position := bestPosition