private
createPaths
	^ self isShortestOnly
		ifTrue: [ 
			| result |
			result := self searcher search.
			self progress: 0.0.
			result ]
		ifFalse: [ 
			| newPaths |
			newPaths := SortedCollection
				sortBlock: [ :less :more | less value < more value or: [ less value = more value and: [ less key size < more key size ] ] ].
			products
				ifNotEmpty: [ 
					self
						reactantsDo: [ :vertex | 
							(self isEffectiveVertex: vertex)
								ifTrue: [ 
									self
										search: (Array with: vertex)
										score: Float fmax negated
										into: newPaths
										from: 0.0
										to: 1.0 ] ] ].
			searchProgress value: 0.0.
			newPaths asArray collect: [ :assoc | assoc key ] ]