private
multiframeEnergies
	^ json
		at: 'multiframe_energies'
		ifAbsent: [ 
			(Array new: self multiframes size)
				at: self multiframeIndex + 1 put: self energy;
				yourself ]