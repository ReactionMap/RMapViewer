private
vertices
	^ vertices
		ifNil: [ 
			| selection |
			selection := Array new: 1 streamContents: [ :stream | rmap selectedVerticesDo: [ :v | stream nextPut: v ] ].
			vertices := selection
				ifEmpty: [ Array new: rmap vertices size streamContents: [ :stream | stream nextPutAll: rmap vertices ] ]
				ifNotEmpty: [ 
					| keySignatures errors |
					keySignatures := selection collect: [ :v | self signatures at: v ifAbsent: [ Dictionary new ] ].
					errors := Array
						new: rmap vertices size
						streamContents: [ :stream | 
							self signatures
								keysAndValuesDo: [ :v :sig | stream nextPut: (keySignatures collect: [ :keySig | self errorBetween: sig and: keySig ]) min -> v ] ].
					(errors asSortedCollection collect: #value) asArray ] ]