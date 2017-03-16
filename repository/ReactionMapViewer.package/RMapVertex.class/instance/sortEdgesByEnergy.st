private
sortEdgesByEnergy
	edges := (((edges
		collect: [ :e | 
			e
				->
					(e vertex1 == self
						ifTrue: [ e vertex2 ]
						ifFalse: [ e vertex1 ]) energy ]) asSortedCollection: [ :less :more | less value <= more value ])
		collect: [ :assoc | assoc key ]) asOrderedCollection