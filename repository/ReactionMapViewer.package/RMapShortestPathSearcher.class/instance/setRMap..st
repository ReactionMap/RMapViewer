private
setRMap: anRMapMorph
	rmap := anRMapMorph.
	reactants := IdentitySet new: 10.
	rmap reactantsDo: [ :vertex | reactants add: vertex ].
	products := IdentitySet new: 10.
	rmap productsDo: [ :vertex | products add: vertex ]