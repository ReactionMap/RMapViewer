enumerating
fromAll: aCollectionOfRMapVertex hops: anInteger verticesDo: vertexBlock edgesDo: edgeBlock
	| agenda done lastEdges |
	agenda := aCollectionOfRMapVertex asArray.
	done := agenda asSet.
	lastEdges := Array new writeStream.
	anInteger + 1
		timesRepeat: [ 
			| newAgenda |
			newAgenda := Array new writeStream.
			lastEdges contents do: edgeBlock.
			lastEdges := Array new writeStream.
			agenda
				do: [ :baseVertex | 
					vertexBlock value: baseVertex.
					baseVertex
						edgesDo: [ :edge | 
							(edge vertex1 ~= baseVertex and: [ (done includes: edge vertex1) not ])
								ifTrue: [ 
									lastEdges nextPut: edge.
									newAgenda nextPut: edge vertex1 ].
							(edge vertex2 ~= baseVertex and: [ (done includes: edge vertex2) not ])
								ifTrue: [ 
									lastEdges nextPut: edge.
									newAgenda nextPut: edge vertex2 ] ] ].
			agenda := newAgenda contents.
			done := done , agenda ]