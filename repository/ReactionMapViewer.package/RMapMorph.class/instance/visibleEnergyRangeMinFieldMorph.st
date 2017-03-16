user interface
visibleEnergyRangeMinFieldMorph
	| morph |
	morph := PluggableTextFieldMorph on: self text: #visibleEnergyRangeMin accept: #visibleEnergyRangeMin:.
	morph convertTo: Number.
	morph acceptOnFocusChange: true.
	morph wrapFlag: false.
	morph hideScrollBarsIndefinitely: true.
	morph acceptOnCR: true.
	^ morph