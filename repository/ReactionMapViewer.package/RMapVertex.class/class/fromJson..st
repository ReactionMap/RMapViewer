instance creation
fromJson: aDictionary
	| label |
	label := (aDictionary at: 'label' ifAbsent: [ 'E' ]) first.
	label = $D
		ifTrue: [ 
			^ RMapDCVertex new
				setJson: aDictionary;
				yourself ].
	label = $T
		ifTrue: [ 
			^ RMapTSVertex new
				setJson: aDictionary;
				yourself ].
	^ RMapEQVertex new
		setJson: aDictionary;
		yourself