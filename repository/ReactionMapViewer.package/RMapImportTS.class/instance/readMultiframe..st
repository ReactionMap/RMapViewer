accessing
readMultiframe: aStream
	| chunks header forwardSteps backwardSteps forwardXYZ forwardEnergies backwardXYZ backwardEnergies geom |
	chunks := '=========================================================================' split: aStream contents.
	header := geometry size printString , String lf , String lf.
	forwardSteps := (String lf , String lf split: chunks second) select: [ :step | '# STEP *' match: step ].
	forwardXYZ := forwardSteps
		collect: [ :step | header , (String lf join: (String lf , 'ENERGY' split: step) first lines copyWithoutFirst) ].
	forwardEnergies := forwardSteps collect: [ :step | ($= split: step lines reverse second) second trim asNumber asFloat ].
	backwardSteps := (String lf , String lf split: chunks fourth) select: [ :step | '# STEP *' match: step ].
	backwardXYZ := backwardSteps
		collect: [ :step | header , (String lf join: (String lf , 'ENERGY' split: step) first lines copyWithoutFirst) ].
	backwardEnergies := backwardSteps
		collect: [ :step | ($= split: step lines reverse second) second trim asNumber asFloat ].
	geom := header
		, (String lf join: (String lf , 'ENERGY' split: chunks first) first lines copyWithoutFirst copyWithoutFirst).
	eq1 label <= eq2 label
		ifTrue: [ 
			multiframeXYZ := forwardXYZ reversed , {geom} , backwardXYZ.
			multiframeEnergies := forwardEnergies reversed , {energy} , backwardEnergies.
			multiframeIndex := forwardXYZ size ]
		ifFalse: [ 
			multiframeXYZ := backwardXYZ reversed , {geom} , forwardXYZ.
			multiframeEnergies := backwardEnergies reversed , {energy} , forwardEnergies.
			multiframeIndex := backwardXYZ size ]