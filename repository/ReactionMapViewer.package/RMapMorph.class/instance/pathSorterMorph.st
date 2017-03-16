user interface
pathSorterMorph
	| morph |
	morph := Morph new.
	morph color: UITheme current settings windowColor.
	morph changeProportionalLayout.
	morph
		addMorph:
			(PluggableButtonMorph
				on: self
				getState: #isDeltaEnergyPathSorter
				action: #setDeltaEnergyPathSorter
				label: #deltaEnergyPathSorter)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 0.15 @ 1)).
	morph
		addMorph:
			(PluggableButtonMorph
				on: self
				getState: #isEnergyPathSorter
				action: #setEnergyPathSorter
				label: #energyPathSorter)
		fullFrame: (LayoutFrame fractions: (0.15 @ 0 corner: 0.3 @ 1)).
	morph
		addMorph:
			(PluggableButtonMorph
				on: self
				getState: #isHopsPathSorter
				action: #setHopsPathSorter
				label: #hopsPathSorter)
		fullFrame: (LayoutFrame fractions: (0.3 @ 0 corner: 0.45 @ 1)).
	morph
		addMorph:
			(PluggableButtonMorph
				on: self
				getState: #isShortestOnly
				action: #toggleShortestOnly
				label: #shortestOnlyLabel)
		fullFrame: (LayoutFrame fractions: (0.45 @ 0 corner: 0.6 @ 1)).
	morph
		addMorph: (RMapLabelMorph contents: 'search depth')
		fullFrame: (LayoutFrame fractions: (0.65 @ 0 corner: 0.75 @ 1)).
	morph
		addMorph:
			((PluggableTextFieldMorph on: self text: #maxNumberOfHops accept: #maxNumberOfHops:)
				convertTo: Integer;
				acceptOnFocusChange: true;
				wrapFlag: false;
				acceptOnCR: true;
				hideScrollBarsIndefinitely: true;
				ghostText: 'max # hops';
				backgroundColor: Color white;
				yourself)
		fullFrame: (LayoutFrame fractions: (0.75 @ 0 corner: 0.80 @ 1)).
	morph
		addMorph: (RMapLabelMorph contents: 'search results')
		fullFrame: (LayoutFrame fractions: (0.80 @ 0 corner: 0.90 @ 1)).
	morph
		addMorph:
			((PluggableTextFieldMorph on: self text: #maxNumberOfPaths accept: #maxNumberOfPaths:)
				convertTo: Integer;
				acceptOnFocusChange: true;
				wrapFlag: false;
				acceptOnCR: true;
				hideScrollBarsIndefinitely: true;
				ghostText: 'max # paths';
				backgroundColor: Color white;
				yourself)
		fullFrame: (LayoutFrame fractions: (0.90 @ 0 corner: 0.95 @ 1)).
	morph
		addMorph:
			((PluggableButtonMorph on: self getState: nil action: #savePathsAsCVS)
				label: 'Save';
				yourself)
		fullFrame: (LayoutFrame fractions: (0.95 @ 0 corner: 1 @ 1)).
	^ morph