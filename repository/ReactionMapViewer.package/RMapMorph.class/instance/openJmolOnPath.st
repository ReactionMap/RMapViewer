user interface
openJmolOnPath
	self xyzAnimationAndLabelDictionaryAndEnergyCurveFromPath
		ifNotNil: [ :pair | 
			self class jmol: pair first captions: pair second energies: pair third]