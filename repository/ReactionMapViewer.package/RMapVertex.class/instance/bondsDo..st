enumerating
bondsDo: aBlock
	bonds do: [ :a1a2type | aBlock valueWithArguments: a1a2type ]