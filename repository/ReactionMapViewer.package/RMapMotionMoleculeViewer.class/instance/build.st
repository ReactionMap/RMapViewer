user interface
build
	self changeProportionalLayout.
	moleculeViewer := RMapMoleculeViewer new.
	self
		addMorph: moleculeViewer
		fullFrame:
			((0 @ 0 corner: 1 @ 1) asLayoutFrame
				bottomOffset: -45;
				yourself).
	jumpToStartButton := IconicButton new
		target: self;
		actionSelector: #jumpToStart;
		color: (Color gray: 0.95);
		labelGraphic: self jumpToStartIcon;
		yourself.
	self
		addMorph: jumpToStartButton
		fullFrame:
			((0 @ 1 corner: 0.2 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself).
	prevCaptionButton := SimpleButtonMorph new
		target: self;
		actionSelector: #jumpToPrevCaption;
		color: (Color gray: 0.95);
		label: '';
		yourself.
	self
		addMorph: prevCaptionButton
		fullFrame:
			((0.2 @ 1 corner: 0.4 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself).
	playPauseButton := IconicButton new
		target: self;
		actionSelector: #togglePlay;
		color: (Color gray: 0.95);
		labelGraphic: self playIcon;
		yourself.
	self
		addMorph: playPauseButton
		fullFrame:
			((0.4 @ 1 corner: 0.6 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself).
	nextCaptionButton := SimpleButtonMorph new
		target: self;
		actionSelector: #jumpToNextCaption;
		color: (Color gray: 0.95);
		label: '';
		yourself.
	self
		addMorph: nextCaptionButton
		fullFrame:
			((0.6 @ 1 corner: 0.8 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself).
	jumpToEndButton := IconicButton new
		target: self;
		actionSelector: #jumpToEnd;
		color: (Color gray: 0.95);
		labelGraphic: self jumpToEndIcon;
		yourself.
	self
		addMorph: jumpToEndButton
		fullFrame:
			((0.8 @ 1 corner: 1 @ 1) asLayoutFrame
				topOffset: -45;
				bottomOffset: -20;
				yourself)