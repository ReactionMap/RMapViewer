user interface
visibleEnergyRangeMaxFieldMorph
	| morph |
	morph := PluggableTextFieldMorph on: self text: #visibleEnergyRangeMax accept: #visibleEnergyRangeMax:.
	morph convertTo: Number.
	morph acceptOnFocusChange: true.
	morph wrapFlag: false.
	morph hideScrollBarsIndefinitely: true.
	morph acceptOnCR: true.
	^ morph