converting
as2dJunMoleculeGeometry
	| molecule |
	molecule := RMapMolecule new.
	self geometry2dDo: [ :atom :x :y :z | molecule addAtom: (JunAtom symbol: atom at: x , y , z) ].
	bonds do: [ :triple | (molecule addBondBetween: triple first and: triple second) order: triple third ].
	^ molecule