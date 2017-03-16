layouting
arrange: nodes
	| scoreBlock bestPosition bestScore x0 y0 gap |
	scoreBlock := [ 
	(nodes
		collect: [ :n | 
			n == self
				ifTrue: [ Float fmax ]
				ifFalse: [ n position dist: position ] ]) min ].
	bestPosition := position.
	bestScore := scoreBlock value.
	x0 := eq position x - (eq gap * 0.5).
	y0 := eq position y - (eq gap * 0.5).
	gap := eq gap.
	50
		timesRepeat: [ 
			| score |
			position := gap * self random + x0 , (gap * self random + y0).
			score := scoreBlock value.
			score > bestScore
				ifTrue: [ 
					bestScore := score.
					bestPosition := position ] ].
	position := bestPosition