accessing
centroidX: anRMapVertex
	| cx  |
	cx := 0.0.
	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			cx := cx + x].
	^ cx / anRMapVertex geometry size asFloat