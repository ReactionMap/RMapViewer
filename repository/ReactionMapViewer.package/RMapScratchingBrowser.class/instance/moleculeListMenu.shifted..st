menu
moleculeListMenu: aMenu shifted: shifted 
	primarySelectionIndex > 0
		ifTrue: [ | v |
			v := moleculeList at: primarySelectionIndex.
			aMenu addTitle: v label.
			((rmap hasProduct: v) or: [ (rmap hasReactant: v) or: [ rmap hasSelection: v ] ])
				ifTrue: [ 
					aMenu
						add: 'unselect' translated
						target: rmap
						selector: #unselect:
						argument: v ].
			(rmap hasSelection: v)
				ifFalse: [ 
					aMenu
						add: 'select' translated
						target: rmap
						selector: #addSelection:
						argument: v ].
			(rmap hasReactant: v)
				ifFalse: [ 
					aMenu
						add: 'reactant' translated
						target: rmap
						selector: #addReactant:
						argument: v ].
			(rmap hasProduct: v)
				ifFalse: [ 
					aMenu
						add: 'product' translated
						target: rmap
						selector: #addProduct:
						argument: v ].
			aMenu
				addLine;
				add: 'open info' translated target: v selector: #openInfo;
				add: 'open in 3D viewer' translated target: v selector: #openJmol;
				add: 'open measure viewer' translated target: v selector: #openMeasureViewer ].
	^ aMenu