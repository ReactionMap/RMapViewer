accessing
json
	^ super json
		at: 'multiframe_xyz' put: multiframeXYZ;
		at: 'multiframe_energies' put: multiframeEnergies;
		yourself