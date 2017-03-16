*ReactionMapViewer
argmax: aBlock
	| argmax max |
	argmax := nil.
	max := Float fmin.
	self
		do: [ :elem | 
			| value |
			value := aBlock value: elem.
			value > max
				ifTrue: [ 
					max := value.
					argmax := elem ] ].
	^ argmax