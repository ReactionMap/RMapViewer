accessing
centroidY: anRMapVertex
	| cy  |
	cy := 0.0.

	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			cy := cy + y].
	^ cy / anRMapVertex geometry size asFloat