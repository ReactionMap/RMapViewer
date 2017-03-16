accessing
json
	| json |
	json := Dictionary new.
	json
		at: 'position'
			put:
				{(position x).
					(position y)};
		at: 'label' put: label;
		at: 'energy' put: energy;
		at: 'geometry' put: geometry;
		at: 'bonds' put: bonds;
		at: 'sdf' put: sdf;
		at: 'smiles' put: smiles;
		at: 'inchi' put: inchi.
	canost ifNotNil: [ json at: 'canost' put: canost ].
	^ json