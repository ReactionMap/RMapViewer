accessing
readMultiframe: aStream
	| chunks header steps forwardXYZ forwardEnergies geom |
	chunks := '=========================================================================' split: aStream contents.
	header := geometry size printString , String lf , String lf.
	steps := (String lf , String lf split: chunks second) select: [ :step | '# STEP *' match: step ].
	forwardXYZ := steps
		collect: [ :step | header , (String lf join: (String lf , 'ENERGY' split: step) first lines copyWithoutFirst) ].
	forwardEnergies := steps collect: [ :step | ($= split: step lines reverse second) second trim asNumber asFloat ].
	geom := header
		, (String lf join: (String lf , 'ENERGY' split: chunks first) first lines copyWithoutFirst copyWithoutFirst).
	multiframeXYZ := forwardXYZ reversed copyWith: geom.
	multiframeEnergies := forwardEnergies reversed copyWith: energy