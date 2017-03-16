drawing
drawOn: aCanvas
	| f |
	f := self fontToUse.
	aCanvas
		drawString: contents
		in: (Rectangle center: self center extent: (f widthOfString: contents) @ f height)
		font: f
		color: color