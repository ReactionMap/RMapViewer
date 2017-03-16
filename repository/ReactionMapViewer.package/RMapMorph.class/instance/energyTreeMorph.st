user interface
energyTreeMorph
	| scrollPane |
	scrollPane := ScrollPane new.
	scrollPane scroller addMorph: 	((RMapEnergyTreeMorph on: self)
		extent: 500@400;
		yourself).
	scrollPane hideVScrollBarIndefinitely: true.
	scrollPane alwaysShowHScrollBar: true.
	scrollPane hScrollBar color: World theme windowColor.
	^ scrollPane
