private
energies
	| energies |
	energies := Set new: rmap vertices size.
	rmap
		edgesDo: [ :edge | 
			edge vertex1 energy - edge vertex2 energy >= 0.0
				ifTrue: [ energies add: edge vertex1 energy - edge vertex2 energy ].
			edge vertex2 energy - edge vertex1 energy >= 0.0
				ifTrue: [ energies add: edge vertex2 energy - edge vertex1 energy ] ].
	^ energies asSortedCollection