converting
asMolecule
	| molecule |
	molecule := RMapMolecule new.
	self geometryDo: [ :atom :x :y :z | molecule addAtom: (JunAtom symbol: atom at: x , y , z) ].
	bonds do: [ :triple | (molecule addBondBetween: triple first and: triple second) order: triple third ].
	molecule energy: self energy.
	molecule label: self label.
	^ molecule