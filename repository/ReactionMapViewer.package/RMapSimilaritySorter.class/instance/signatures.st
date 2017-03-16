private
signatures
	^ signatures
		ifNil: [ 
			| sigs |
			sigs := IdentityDictionary new.
			rmap vertices do: [ :v | sigs at: v put: v fullShapeSignature ].
			signatures := sigs ]