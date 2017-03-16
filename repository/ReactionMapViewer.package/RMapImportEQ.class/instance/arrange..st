layouting
arrange: eqs
	| bestScore bestEq |
	bestScore := 1.0e-5.
	bestEq := nil.
	eqs
		do: [ :eq | 
			| p score |
			p := position.
			score := (tss collect: #span) sum0 + (eq tss collect: #span) sum0.
			position := eq position.
			eq position: p.
			score := score - (tss collect: #span) sum0 - (eq tss collect: #span) sum0.
			eq position: position.
			position := p.
			score > bestScore
				ifTrue: [ 
					bestScore := score.
					bestEq := eq ] ].
	bestEq ifNil: [ ^ false ].
	bestEq == self
		ifTrue: [ ^ false ].
	self swap: bestEq.
	^ true