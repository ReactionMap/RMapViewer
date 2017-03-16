private
createForm
	| newForm |
	newForm := Form extent: self extent depth: 32.
	newForm getCanvas
		in: [ :canvas | 
			| eScale |
			canvas fillColor: Color white.
			e0 := motionMolecule e0.
			eMin := motionMolecule eMin.
			eMax := motionMolecule eMax.
			offsetX := 200.
			offsetY := newForm height - 20.
			scaleX := (newForm width - 220) / indexToTime last.
			scaleY := (40 - newForm height) / (eMax - eMin).
			eScale := 10 raisedTo: (((motionMolecule eMax - e0) abs max: (motionMolecule eMin - e0) abs) * 2625.49962) log floor.
			canvas
				drawString: 'name'
				at: 2 @ 2
				font: font
				color: Color black.
			canvas
				drawString: 'Energy (kJ/mol)'
				at: 50 @ 2
				font: font
				color: Color black.
			(((1 to: motionMolecule size) collect: [ :index | motionMolecule at: index ])
				select: [ :molecule | molecule label notNil ])
				keysAndValuesDo: [ :index :molecule | 
					| y eStr |
					y := font height * index + 2.
					eStr := (molecule energy - e0) * 2625.49962 printShowingDecimalPlaces: 8.
					canvas
						drawString: molecule label
						at: 2 @ y
						font: font
						color: Color black.
					canvas
						drawString: eStr
						at: (offsetX - (font widthOfString: eStr) - 65) @ y
						font: font
						color: Color black ].
			(motionMolecule eMin * 2625.49962 quo: eScale) to: (motionMolecule eMax * 2625.49962 quo: eScale) do: [ :i | 
				| e eStr |
				e := eScale * i / 2625.49962 + e0.
				eStr := (eScale * i) asFloat printShowingDecimalPlaces: 1.
				canvas
					drawString: eStr
					at: (self pointFromI: 1 energy: e) - ((3 + (font widthOfString: eStr)) @ (font height // 2))
					font: font
					color: Color black.
				canvas
					line: (self pointFromI: 1 energy: e)
					to: (self pointFromI: motionMolecule size energy: e)
					width: 1
					color: Color lightGray ].
			canvas
				drawString: 'kJ/mol'
				at: (offsetX - (font widthOfString: 'kJ/mol ')) @ 2
				font: font
				color: Color black.
			1 to: motionMolecule size do: [ :index | 
				(motionMolecule at: index) label
					ifNotNil: [ :caption | 
						canvas
							drawString: caption
							at: (self pointFromI: index energy: eMin) + (((font widthOfString: caption) / -2.0) @ 1)
							font: font
							color: Color black.
						canvas
							line: (self pointFromI: index energy: eMin)
							to: (self pointFromI: index energy: eMax)
							width: 1
							color: Color lightGray ] ].
			1 to: motionMolecule size - 1 do: [ :index | 
				canvas
					line: (self pointFromI: index energy: (motionMolecule energyAt: index))
					to: (self pointFromI: index + 1 energy: (motionMolecule energyAt: index + 1))
					width: 2
					color: Color black ] ].
	^ newForm