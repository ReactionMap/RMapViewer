layouting
swap: eq
	| p |
	p := position.
	position := eq position.
	eq position: p