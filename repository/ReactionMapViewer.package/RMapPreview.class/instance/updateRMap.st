private
updateRMap
	| meta vertices |
	(rmap isNil or: [ (rmap includesKey: 'meta') not ])
		ifTrue: [ 
			self nameLabel label: '-'.
			self componentsLabel label: '-'.
			self vertexList
				items: Array new;
				resetSelection.
			^ self ].
	meta := rmap at: 'meta'.
	self nameLabel label: (meta at: 'name' ifAbsent: [ '' ]).
	self componentsLabel
		label:
			(meta at: 'numEQ' ifAbsent: [ 0 ]) asString , ' EQs, ' , (meta at: 'numTS' ifAbsent: [ 0 ]) asString , ' TSs, '
				, (meta at: 'numDC' ifAbsent: [ 0 ]) asString , ' DCs'.
	vertices := (meta at: 'stableEQs') collect: [ :json | RMapVertex fromJson: json ].
	vertices do: [ :vertex | vertex baselineEnergy: vertices first energy ].
	self vertexList
		items: vertices;
		resetSelection