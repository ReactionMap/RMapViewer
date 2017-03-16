private
errorBetween: signature1 and: signature2
	| error |
	error := 0.0.
	signature1
		keysAndValuesDo: [ :atoms :distances1 | 
			signature2
				at: atoms
				ifPresent: [ :distances2 | 
					1 to: (distances1 size min: distances2 size) do: [ :i | 
						| d1 d2 |
						d1 := distances1 at: i.
						d2 := distances2 at: i.
						error := (d1 - d2) abs / (d1 max: d2) + error ].
					error := (distances1 size - distances2 size) abs + error ]
				ifAbsent: [ error := distances1 size + error ] ].
	signature2
		keysAndValuesDo: [ :atoms :distances2 | signature1 at: atoms ifAbsent: [ error := distances2 size + error ] ].
	^ error