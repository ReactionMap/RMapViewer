*ReactionMapViewer
argmin: aBlock
	| argmin min |
	argmin := nil.
	min := Float fmax.
	self
		do: [ :elem | 
			| value |
			value := aBlock value: elem.
			value < min
				ifTrue: [ 
					min := value.
					argmin := elem ] ].
	^ argmin