drawing
drawOn: aCanvas
	aCanvas fillRectangle: self bounds color: (Color gray: 0.8).
	(self yAtEnergy: self lowerBound)
		in: [ :maxY | 
			(self yAtEnergy: self upperBound)
				in: [ :minY | aCanvas fillRectangle: (self left @ minY corner: self right @ maxY) color: Color white ] ].
	((1 to: distribution size)
		collect: [ :index | 
			| x y |
			x := (distribution at: index) * self width + self left.
			y := self bottom - (self height * (index - 1.0) / distribution size).
			x @ y ])
		in: [ :points | 
			1 to: points size - 1 do: [ :index | 
				| p1 p2 |
				p1 := points at: index.
				p2 := points at: index + 1.
				aCanvas
					drawPolygon:
						(Array
							with: self left @ p1 y
							with: p1
							with: p2
							with: self left @ p2 y)
					fillStyle: Color gray.
				aCanvas line: p1 to: p2 color: Color black ] ]