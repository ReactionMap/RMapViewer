initialize-release
initialize
	super initialize.
	self extent: self initialExtent.
	font := TextStyle defaultFont.
	self changeProportionalLayout.
	self
		addMorph:
			((SimpleButtonMorph newWithLabel: 'Save')
				target: self;
				actionSelector: #saveAsCVS;
				color: Color white;
				yourself)
		fullFrame:
			((0 @ 1 corner: 0 @ 1) asLayoutFrame
				topOffset: -20;
				rightOffset: 140;
				yourself)