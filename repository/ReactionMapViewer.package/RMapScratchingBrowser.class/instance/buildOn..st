interface building
buildOn: aMorph
	aMorph changeProportionalLayout.
	aMorph
		addMorph: (scratcherMorph := RMapMoleculeScratcherMorph new)
		fullFrame:
			((0 @ 0 corner: 1 @ 1) asLayoutFrame
				rightOffset: -200;
				bottomOffset: -100).
	aMorph
		addMorph:
			(periodicTableMorph := JunPeriodicTableMorph new
				selectedAtom: JunCarbon;
				action: [ :atomClass | scratcherMorph defaultAtomClass: atomClass ];
				yourself)
		fullFrame:
			((0 @ 1 corner: 1 @ 1) asLayoutFrame
				rightOffset: -200;
				topOffset: -100).
	aMorph
		addMorph:
			((searchButton := CheckboxMorph on: self selected: #isStrict changeSelected: #isStrict:)
				label: 'structural';
				yourself)
		fullFrame:
			((1 @ 0 corner: 1 @ 0) asLayoutFrame
				leftOffset: -200;
				rightOffset: -150;
				bottomOffset: 20;
				yourself).
	aMorph
		addMorph:
			((searchButton := SimpleButtonMorph newWithLabel: 'Search')
				target: self;
				actionSelector: #search;
				color: Color white;
				yourself)
		fullFrame:
			((1 @ 0 corner: 1 @ 0) asLayoutFrame
				leftOffset: -100;
				bottomOffset: 20;
				yourself).
	aMorph
		addMorph:
			(listMorph := (RMapPluggableVertexListMorph
				on: self
				list: #moleculeList
				primarySelection: #primarySelectionIndex
				changePrimarySelection: #primarySelectionIndex:
				listSelection: #listSelectionAt:
				changeListSelection: #listSelectionAt:put:
				menu: #moleculeListMenu:shifted:)
				wrapSelector: #asListItem;
				yourself)
		fullFrame:
			((1 @ 0 corner: 1 @ 1) asLayoutFrame
				topOffset: 20;
				leftOffset: -200;
				yourself)