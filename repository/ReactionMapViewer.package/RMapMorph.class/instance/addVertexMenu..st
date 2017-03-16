menu
addVertexMenu: aMenu
	hoverVertex
		ifNil: [ 
			aMenu addTitle: 'RMap'.
			(aMenu add: 'show GRRM run params' translated target: self selector: #showGRRM) enabled: grrm notNil ]
		ifNotNil: [ :v | 
			aMenu addTitle: v label.
			((products includes: v) or: [ (reactants includes: v) or: [ selectedVertices includes: v ] ])
				ifTrue: [ 
					aMenu
						add: 'unselect' translated
						target: self
						selector: #unselect:
						argument: v ].
			(selectedVertices includes: v)
				ifFalse: [ 
					aMenu
						add: 'select' translated
						target: self
						selector: #addSelection:
						argument: v ].
			(reactants includes: v)
				ifFalse: [ 
					aMenu
						add: 'reactant' translated
						target: self
						selector: #addReactant:
						argument: v ].
			(products includes: v)
				ifFalse: [ 
					aMenu
						add: 'product' translated
						target: self
						selector: #addProduct:
						argument: v ].
			aMenu
				addLine;
				add: 'open info' translated target: v selector: #openInfo;
				add: 'open in 3D viewer' translated target: v selector: #openJmol;
				add: 'open measure viewer' translated target: v selector: #openMeasureViewer ].
	aMenu
		addLine;
		add: 'open tree map' translated target: self selector: #openTreeViewer.
	(Smalltalk includesKey: #RMapServer)
		ifTrue: [ 
			aMenu
				addLine;
				add: 'load from local server' translated target: self selector: #loadFromLocalServer;
				add: 'store to local server' translated target: self selector: #storeToLocalServer ].
	^ aMenu