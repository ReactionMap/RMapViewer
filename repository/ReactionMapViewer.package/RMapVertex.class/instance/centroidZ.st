private
centroidZ
	| cz  |
	cz := 0.0.
	self
		geometryDo: [ :atom :x :y :z | 
			cz := cz + z].
	^ cz / self geometry size asFloat