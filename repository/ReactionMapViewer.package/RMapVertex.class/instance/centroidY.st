private
centroidY
	| cy  |
	cy := 0.0.
	self
		geometryDo: [ :atom :x :y :z | 
			cy := cy + y].
	^ cy / self geometry size asFloat