private
geometryMatrix: anRMapVertex
	| matrix cx cy cz |
	matrix := (Array new: anRMapVertex geometry size) writeStream.
	cx := self centroidX: anRMapVertex.
	cy := self centroidY: anRMapVertex.
	cz := self centroidZ: anRMapVertex.
	anRMapVertex geometryDo: [ :atom :x :y :z | matrix nextPut: (Array with: x - cx with: y - cy with: z - cz) ].
	^ matrix contents