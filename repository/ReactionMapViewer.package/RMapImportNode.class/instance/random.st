accessing
random
	^ (Rand ifNil: [ Rand := Random new ]) next