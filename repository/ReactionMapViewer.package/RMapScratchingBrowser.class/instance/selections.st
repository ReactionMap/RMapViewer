accessing
selections
	^ listSelection ifNotNil: [ listSelection asSortedCollection collect: [ :index | moleculeList at: index ] ]