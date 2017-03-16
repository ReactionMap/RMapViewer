private
geometryMatrix
	| matrix cx cy cz |
	matrix := (Array new: self geometry size) writeStream.
	cx := self centroidX.
	cy := self centroidY.
	cz := self centroidZ.
	self geometryDo: [ :atom :x :y :z | matrix nextPut: (Array with: x - cx with: y - cy with: z - cz) ].
	^ matrix contents