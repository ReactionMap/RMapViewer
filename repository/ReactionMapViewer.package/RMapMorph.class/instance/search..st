viewer functions
search: aString
	| terms |
	terms := aString substrings.
	selectedVertices := terms isEmpty
		ifTrue: [ Array new ]
		ifFalse: [ 
			(vertices
				select: [ :vertex | 
					| label smiles inchi canost |
					label := vertex label.
					smiles := vertex at: 'smiles' ifAbsent: [ '' ].
					inchi := vertex at: 'inchi' ifAbsent: [ '' ].
					canost := vertex at: 'canost' ifAbsent: [ '' ].
					terms
						allSatisfy: [ :term | 
							label = term
								or: [ (smiles findString: term) > 0 or: [ (inchi findString: term) > 0 or: [ (canost findString: term) > 0 ] ] ] ] ])
				asArray ]