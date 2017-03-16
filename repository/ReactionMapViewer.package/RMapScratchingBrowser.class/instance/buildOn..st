interface building
buildOn: aMorph
	aMorph changeProportionalLayout.
	aMorph
		addMorph: (scratcherMorph := JunMoleculeScratcherMorph new)
		fullFrame: ((0 @ 0 corner: 1 @ 1) asLayoutFrame rightOffset: -200).
	aMorph
		addMorph:
			((searchButton := CheckboxMorph on: self selected: #isStrict changeSelected: #isStrict:)
				label: 'strict';
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
				leftOffset: -150;
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
				menu: nil)
				wrapSelector: #asListItem;
				yourself)
		fullFrame:
			((1 @ 0 corner: 1 @ 1) asLayoutFrame
				topOffset: 20;
				leftOffset: -200;
				yourself)