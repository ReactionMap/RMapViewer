accessing
xyz
	^ Array new writeStream
		in: [ :stream | 
			stream nextPutAll: self geometry size printString.
			stream cr.
			stream cr.
			self geometry
				in: [ :geoms | 
					geoms
						do: [ :geom | 
							stream nextPutAll: geom first.
							stream space.
							stream nextPutAll: geom second printString.
							stream space.
							stream nextPutAll: geom third printString.
							stream space.
							stream nextPutAll: geom fourth printString.
							stream cr ] ].
			stream contents ]