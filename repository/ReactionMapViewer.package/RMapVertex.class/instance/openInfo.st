utilities
openInfo
	| font lines extent |
	font := TextStyle default defaultFont.
	lines := (Array
		with: 'label'
		with: 'energy'
		with: 'smiles'
		with: 'inchi'
		with: 'canost') collect: [ :attribute | attribute , ': ' , (self at: attribute ifAbsentPut: [ 'N/A' ]) asString ].
	extent := ((lines inject: 0 into: [ :max :each | max max: (font widthOfString: each) ]) + 4)
		@ (lines size * font height + 4).
	(Text
		initialFont: font
		stringOrText:
			(String streamContents: [ :stream | lines do: [ :line | stream nextPutAll: line ] separatedBy: [ stream cr ] ]))
		asMorph
		extent: extent;
		backgroundColor: Color white;
		openInWindowLabeled: self label;
		color: Color black