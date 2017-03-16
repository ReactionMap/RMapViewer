accessing
blackForm
	^ BlackForm
		ifNil: [ 
			| form |
			form := Form extent: 3 @ 3 depth: 32.
			form getCanvas in: [ :canvas | canvas fillColor: Color black ].
			BlackForm := form ]