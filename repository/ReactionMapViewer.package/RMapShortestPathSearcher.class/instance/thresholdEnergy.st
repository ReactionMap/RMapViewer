private
thresholdEnergy
	| energies min max |
	energies := self energies.
	min := 1.
	max := energies size.
	[ min = max ]
		whileFalse: [ 
			| index |
			index := (min + max + 1) // 2.
			(self isReachableWith: (self edgesWithin: (energies at: index)))
				ifTrue: [ max := index - 1 ]
				ifFalse: [ min := index ] ].
	^ energies at: min + 1 ifAbsent: [  ]