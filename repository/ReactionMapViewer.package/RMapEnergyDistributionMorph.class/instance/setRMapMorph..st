private
setRMapMorph: anRMapMorph
	rmapMorph := anRMapMorph.
	rmapMorph addDependent: self.
	self updateDistribution