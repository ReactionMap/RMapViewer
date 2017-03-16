private
centroidX
	| cx  |
	cx := 0.0.
	self
		geometryDo: [ :atom :x :y :z | 
			cx := cx + x].
	^ cx / self geometry size asFloat