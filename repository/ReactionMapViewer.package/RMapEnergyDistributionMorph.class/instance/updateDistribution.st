private
updateDistribution
	rmapMorph
		ifNil: [ distribution := Array new: 100 withAll: 0 ]
		ifNotNil: [ 
			| tmpMin tmpMax a tmpDistribution peak |
			tmpMin := rmapMorph energyRangeMin.
			tmpMax := rmapMorph energyRangeMax.
			a := 100.0 / (tmpMax - tmpMin) asFloat.
			tmpDistribution := Array new: 100 withAll: 0.
			rmapMorph
				verticesDo: [ :vertex | 
					| index |
					index := (vertex energy - tmpMin) * a + 1 min: 100 max: 1.
					tmpDistribution at: index put: (tmpDistribution at: index) + 1 ].
			peak := tmpDistribution max asFloat.
			distribution := tmpDistribution collect: [ :num | num asFloat / peak ] ].
	self changed