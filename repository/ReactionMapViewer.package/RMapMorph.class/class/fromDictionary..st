instance creation
fromDictionary: json
	| rmap |
	rmap := self new.
	rmap extent: 500 @ 500.
	(json at: 'vertices' ifAbsent: [ #() ]) do: [ :vertex | rmap addVertex: (RMapVertex fromJson: vertex) ].
	(json at: 'edges' ifAbsent: [ #() ])
		do: [ :edge | rmap addEdgeBetween: (edge at: 'vertex1') + 1 and: (edge at: 'vertex2') + 1 ].
	rmap grrm: (json at: 'grrm' ifAbsent: [  ]).
	rmap sortVerticesByEnergy.
	rmap sortEdgesByEnergy.
	^ rmap