user interface
playIcon
	^ playIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			form getCanvas
				drawPolygon:
					{(5 @ 5).
					(5 @ 15).
					(15 @ 10)}
				color: Color black
				borderWidth: 0
				borderColor: Color black.
			playIcon := form ]