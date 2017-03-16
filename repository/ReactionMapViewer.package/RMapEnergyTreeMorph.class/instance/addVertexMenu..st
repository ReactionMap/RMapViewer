menu
addVertexMenu: aMenu
	hoverVertex ifNotNil:[:v | 
		aMenu addTitle: v label.
		((rmapMorph hasProduct: v) or: [(rmapMorph hasReactant: v) or: [rmapMorph hasSelection: v]])
			ifTrue: [aMenu add: 'unselect' translated target: rmapMorph selector: #unselect: argument: v].
		(rmapMorph hasSelection: v)
			ifFalse: [aMenu add: 'select' translated target: rmapMorph selector: #addSelection: argument: v].
		(rmapMorph hasReactant: v)
			ifFalse: [aMenu add: 'reactant' translated target: rmapMorph selector: #addReactant: argument: v].
		(rmapMorph hasProduct: v)
			ifFalse: [aMenu add: 'product' translated target: rmapMorph selector: #addProduct: argument: v].
		aMenu addLine.
		aMenu add: 'open info' translated target: v selector: #openInfo.
		aMenu add: 'open in Jmol' translated target: v selector: #openJmol].
	^ aMenu