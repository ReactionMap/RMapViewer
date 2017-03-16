private
energies
	^ (rmap vertices collect: [ :v | v energy ]) asSet asSortedCollection