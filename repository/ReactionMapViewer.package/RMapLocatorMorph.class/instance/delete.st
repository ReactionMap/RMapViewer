submorphs-add/remove
delete
	rmapMorph
		ifNotNil: [ 
			rmapMorph removeDependent: self.
			rmapMorph := nil ].
	super delete