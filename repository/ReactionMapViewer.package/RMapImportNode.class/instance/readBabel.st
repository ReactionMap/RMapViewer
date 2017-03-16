babel
readBabel
	sdf := JunBabelWrapper convert: self xyz from: 'xyz' to: 'mol'.
	bonds := Array
		new: 16
		streamContents: [ :stream | 
			JunBabelWrapper
				bondsFromMol: sdf
				do: [ :atom1 :atom2 :bond | 
					stream
						nextPut:
							{(atom1 - 1).
							(atom2 - 1).
							bond} ] ].
	smiles := ((JunBabelWrapper convert: self xyz from: 'xyz' to: 'can') lines first readStream upTo: Character tab) trim.
	inchi := ('InChI=' split: (JunBabelWrapper convert: self xyz from: 'xyz' to: 'inchi')) second lines first trim.
	canost := (JunBabelWrapper
		exec: (FileLocator imageDirectory / 'main_canost') fullName
		args:
			{'-u'.
			'f'.
			'/dev/stdin'.
			'/dev/stdout'}
		stdin: sdf) lines in: [ :lines | lines first trim ifEmpty: [ lines third strip ] ifNotEmpty: [ nil ] ]