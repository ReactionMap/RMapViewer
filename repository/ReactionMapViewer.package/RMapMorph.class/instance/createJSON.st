private
createJSON
	| json invVertices vs es |
	json := Dictionary new.
	json at: 'grrm' put: self grrm.
	invVertices := IdentityDictionary new: vertices size.
	vs := Array new: vertices size.
	1 to: vertices size do: [ :index | 
		invVertices at: (vertices at: index) put: index - 1.
		vs at: index put: (vertices at: index) json ].
	json at: 'vertices' put: vs.
	es := Array new: edges size.
	1 to: edges size do: [ :index | 
		es
			at: index
			put:
				{('vertex1' -> (invVertices at: (edges at: index) vertex1)).
				('vertex2' -> (invVertices at: (edges at: index) vertex2))} asDictionary ].
	json at: 'edges' put: es.
	^ json