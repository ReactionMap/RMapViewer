menu
addYellowButtonMenuItemsTo: aMenu event: evt
	"Populate aMenu with appropriate menu items for a  
	yellow-button (context menu) click."

	super addYellowButtonMenuItemsTo: aMenu event: evt.
	aMenu
		add: 'measure mode'
		subMenu:
			(MenuMorph new
				addToggle: 'distance'
					target: self
					selector: #setDistanceMode
					getStateSelector: #isDistanceMode;
				addToggle: 'angle'
					target: self
					selector: #setAngleMode
					getStateSelector: #isAngleMode;
				addToggle: 'dihedral angle'
					target: self
					selector: #setDihedralAngleMode
					getStateSelector: #isDihedralAngleMode;
				yourself)