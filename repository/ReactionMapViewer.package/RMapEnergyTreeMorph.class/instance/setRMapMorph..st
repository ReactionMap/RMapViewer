private
setRMapMorph: anRMapMorph
	rmapMorph
		ifNotNil: [ 
			rmapMorph pathSelector removeDependent: self.
			rmapMorph removeDependent: self ].
	rmapMorph := anRMapMorph.
	rmapMorph addDependent: self.
	rmapMorph pathSelector addDependent: self