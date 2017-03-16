utilities
openDialogOn: anRMapMorph
	| window pane browser |
	window := SystemWindow new.
	window setLabel: 'Sketch and Search'.
	pane := Morph new.
	pane color: Color white.
	browser := (self on: anRMapMorph) buildOn: pane.
	window
		addMorph: pane
		fullFrame:
			((0 @ 0 corner: 1 @ 1) asLayoutFrame
				bottomOffset: -20;
				yourself).
	window
		addMorph:
			((SimpleButtonMorph newWithLabel: 'OK')
				target: [ window close ];
				actionSelector: #value;
				color: Color white;
				yourself)
		fullFrame:
			((1 @ 1 corner: 1 @ 1) asLayoutFrame
				topOffset: -20;
				leftOffset: -200;
				rightOffset: -100;
				yourself).
	window
		addMorph:
			((SimpleButtonMorph newWithLabel: 'Cancel')
				target: [ 
							browser cancel.
							window close ];
				actionSelector: #value;
				color: Color white;
				yourself)
		fullFrame:
			((1 @ 1 corner: 1 @ 1) asLayoutFrame
				topOffset: -20;
				leftOffset: -100;
				yourself).
	(SystemWindow topWindow ifNil: [ World ]) openModal: window.
	^ browser