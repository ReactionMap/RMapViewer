user interface
buildViewer
	| pane h upper energy lower viewer |
	h := TextStyle default defaultFont height.
	pane := Morph new.
	pane color: Color white.
	pane changeProportionalLayout.
	pane
		addMorph: xNumerizerSelector asDropListMorph
		fullFrame:
			((0 @ 1 corner: 0.2 @ 1) asLayoutFrame
				topOffset: -20;
				yourself).
	pane
		addMorph: yNumerizerSelector asDropListMorph
		fullFrame:
			((0.2 @ 1 corner: 0.4 @ 1) asLayoutFrame
				topOffset: -20;
				yourself).
	pane
		addMorph: zNumerizerSelector asDropListMorph
		fullFrame:
			((0.4 @ 1 corner: 0.6 @ 1) asLayoutFrame
				topOffset: -20;
				yourself).
	pane
		addMorph: projectorSelector asDropListMorph
		fullFrame:
			((0.6 @ 1 corner: 0.8 @ 1) asLayoutFrame
				topOffset: -20;
				yourself).
	pane
		addMorph: rendererSelector asDropListMorph
		fullFrame:
			((0.8 @ 1 corner: 1 @ 1) asLayoutFrame
				topOffset: -20;
				yourself).
	pane addMorph: self searchBox fullFrame: ((0 @ 0 corner: 1 @ 0) asLayoutFrame bottomRightOffset: -220 @ (h + 4)).
	pane
		addMorph:
			('EQ: ' , (vertices select: [ :v | v label first = $E ]) size printString , ' TS: '
				, (vertices select: [ :v | v label first = $T ]) size printString , ' DC: '
				, (vertices select: [ :v | v label first = $D ]) size printString) asMorph
		fullFrame:
			((1 @ 0 corner: 1 @ 0) asLayoutFrame
				leftOffset: -220;
				bottomOffset: h + 4;
				yourself).
	pane
		addMorph:
			((SimpleButtonMorph newWithLabel: 'Sketch')
				target: self;
				actionSelector: #openScratchingBrowser;
				color: Color white;
				yourself)
		fullFrame:
			((1 @ 0 corner: 1 @ 0) asLayoutFrame
				leftOffset: -70;
				bottomOffset: h + 4;
				yourself).
	pane
		addMorph: self
		fullFrame:
			((0 @ 0 corner: 1 @ 1) asLayoutFrame
				topOffset: h + 4;
				bottomOffset: -20;
				yourself).
	upper := BorderedMorph new.
	upper color: Color white.
	upper changeProportionalLayout.
	upper addMorph: pane fullFrame: (0 @ 0 corner: 0.5 @ 1) asLayoutFrame.
	energy := Morph new.
	energy color: Color white.
	energy changeProportionalLayout.
	energy
		addMorph: self visibleEnergyRangeMaxFieldMorph
		fullFrame:
			((0 @ 0 corner: 0 @ 0) asLayoutFrame
				topLeftOffset: 0 @ 10;
				bottomRightOffset: 100 @ 30;
				yourself).
	energy
		addMorph: self energyDistributionMorph
		fullFrame:
			((0 @ 0 corner: 0 @ 1) asLayoutFrame
				topLeftOffset: 0 @ 30;
				bottomRightOffset: 100 @ -20;
				yourself).
	energy
		addMorph: self visibleEnergyRangeMinFieldMorph
		fullFrame:
			((0 @ 1 corner: 0 @ 1) asLayoutFrame
				topLeftOffset: 0 @ -20;
				bottomRightOffset: 100 @ 0;
				yourself).
	energy
		addMorph: self energyTreeMorph
		fullFrame:
			((0 @ 0 corner: 1 @ 1) asLayoutFrame
				topLeftOffset: 100 @ 0;
				bottomRightOffset: 0 @ 0;
				yourself).
	upper addMorph: energy fullFrame: (0.5 @ 0 corner: 1 @ 1) asLayoutFrame.
	upper addPaneSplitters.
	lower := BorderedMorph new.
	lower color: Color white.
	lower changeProportionalLayout.
	lower addMorph: self locatorMorph fullFrame: (0 @ 0 corner: 0.1 @ 1) asLayoutFrame.
	lower
		addMorph: self pathSorterMorph
		fullFrame:
			((0.1 @ 0 corner: 1 @ 0) asLayoutFrame
				bottomOffset: 20;
				yourself).
	lower
		addMorph: self pathListMorph
		fullFrame:
			((0.1 @ 0 corner: 1 @ 1) asLayoutFrame
				topOffset: 20;
				bottomOffset: -20;
				yourself).
	lower
		addMorph: (searchProgress := ProgressBarMorph from: 0.0 to: 1.0)
		fullFrame:
			((0.1 @ 1 corner: 1 @ 1) asLayoutFrame
				topOffset: -20;
				yourself).
	lower addPaneSplitters.
	viewer := BorderedMorph new.
	viewer color: Color white.
	viewer changeProportionalLayout.
	viewer addMorph: upper fullFrame: (0 @ 0 corner: 1 @ 0.7) asLayoutFrame.
	viewer addMorph: lower fullFrame: (0 @ 0.7 corner: 1 @ 1) asLayoutFrame.
	viewer addPaneSplitters.
	^ viewer