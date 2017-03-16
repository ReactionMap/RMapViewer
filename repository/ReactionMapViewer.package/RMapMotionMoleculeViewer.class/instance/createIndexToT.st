private
createIndexToT
	| ts lastIndex |
	ts := Array new: motionMolecule size.
	ts isEmpty
		ifTrue: [ ^ ts ].
	lastIndex := 1.
	ts at: 1 put: 0.0.
	2 to: motionMolecule size do: [ :index | 
		(motionMolecule at: index) label
			ifNotNil: [ 
				lastIndex + 1 to: index do: [ :i | ts at: i put: (i - lastIndex) / (index - lastIndex) asFloat + (ts at: lastIndex) ].
				lastIndex := index ] ].
	^ ts collect: [ :t | t / ts last ]