user interface
emptyIcon
	^ emptyIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			emptyIcon := form ]