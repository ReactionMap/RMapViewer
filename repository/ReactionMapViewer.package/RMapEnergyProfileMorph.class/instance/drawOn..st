drawing
drawOn: aCanvas
	aCanvas drawImage: self form at: self position.
	aCanvas
		line: self position + (self pointFromI: moleculeIndex energy: eMin)
		to: self position + (self pointFromI: moleculeIndex energy: eMax)
		width: 1
		color: Color red