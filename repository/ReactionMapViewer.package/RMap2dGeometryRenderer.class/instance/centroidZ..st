accessing
centroidZ: anRMapVertex
	| cz  |
	cz := 0.0.
	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			cz := cz + z].
	^ cz / anRMapVertex geometry size asFloat