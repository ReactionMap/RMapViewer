private
inchi
	^ (JunBabelWrapper convert: scratcherMorph moleculeGeometry asXYZString from: 'xyz' to: 'inchi') trim
		ifNotEmpty: [ :inchi | inchi copyFrom: (inchi indexOf: $=) + 1 to: inchi size ]