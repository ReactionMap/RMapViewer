*ReactionMapViewer
withTextBelow: aSymbolOrABlock
	| newShape |
	newShape := RTCompositeShape new.
	newShape add: shape.
	newShape add: (RTLabel new text: aSymbolOrABlock).
	newShape vertical.
	newShape setAutomaticRelayout.
	shape := newShape