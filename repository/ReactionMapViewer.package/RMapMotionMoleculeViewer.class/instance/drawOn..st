drawing
drawOn: aCanvas
	| font xOffset yOffset xScale |
	font := TextStyle defaultFont.
	xOffset := self bounds left + 20.
	yOffset := self bounds bottom - 15.
	xScale := self bounds width - 40.
	aCanvas
		fillRectangle:
			(((indexToT at: 1) * xScale + xOffset) @ (yOffset - 4)
				corner: ((indexToT at: moleculeIndex) * xScale + xOffset) @ (yOffset - 2))
		color: Color darkGray.
	1 to: motionMolecule size do: [ :index | 
		(motionMolecule at: index) label
			ifNotNil: [ :caption | 
				| x |
				x := (indexToT at: index) * xScale + xOffset.
				aCanvas
					drawString: caption
						at: (x - ((font widthOfString: caption) * 0.5)) @ yOffset
						font: font
						color: Color black;
					line: x @ (yOffset - 5)
						to: x @ (yOffset - 2)
						width: 1
						color: Color gray ] ]