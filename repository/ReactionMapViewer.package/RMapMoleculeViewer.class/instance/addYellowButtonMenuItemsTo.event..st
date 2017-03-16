menu
addYellowButtonMenuItemsTo: aMenu event: evt
	"Populate aMenu with appropriate menu items for a  
	yellow-button (context menu) click."

	aMenu defaultTarget: self.
	self defaultYellowButtonMenuEnabled
		ifFalse: [ ^ self ].
	aMenu
		addStayUpItem
		addTitle: (label ifNil: ['Molecule Viewer']).
	aMenu
		add: 'presentation'
			subMenu:
				(MenuMorph new
						addToggle: 'stick and ball'
							target: self
							selector: #stickAndBallPresentation
							getStateSelector: #isStickAndBallPresentation;
						addToggle: 'tube'
							target: self
							selector: #tubePresentation
							getStateSelector: #isTubePresentation;
						addToggle: 'van der waals'
							target: self
							selector: #vanDerWaalsPresentation
							getStateSelector: #isVanDerWaalsPresentation;
						yourself);
		add: 'background'
			subMenu:
				(MenuMorph new
						addToggle: 'black'
							target: self
							selector: #blackBackground
							getStateSelector: #isBlackBackground;
						addToggle: 'white'
							target: self
							selector: #whiteBackground
							getStateSelector: #isWhiteBackground;
						add: 'color...' target: self selector: #chooseBackgroundColor;
						yourself)