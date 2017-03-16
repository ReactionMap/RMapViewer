user interface
showGRRM
	UITheme current
		textEditorIn: self
		text: (grrm readStream upTo: Character lf)
		title: 'GRRM run params'
		entryText: grrm
		entryHeight: 200