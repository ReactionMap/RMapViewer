Class {
	#name : #RMapScratchingBrowser,
	#superclass : #Model,
	#instVars : [
		'rmap',
		'scratcherMorph',
		'periodicTableMorph',
		'listMorph',
		'loadButton',
		'searchButton',
		'moleculeList',
		'primarySelectionIndex',
		'listSelection',
		'sortByEnergy',
		'sortByEnergyCheckbox'
	],
	#category : #'ReactionMapViewer-Morphs'
}

{ #category : #'instance creation' }
RMapScratchingBrowser class >> on: anRMapMorph [
	^ self new
		setRMap: anRMapMorph;
		yourself
]

{ #category : #utilities }
RMapScratchingBrowser class >> openDialogOn: anRMapMorph [

	| window pane browser |
	window := SystemWindow new.
	window
		setLabel: 'Sketch and Search';
		extent: 500 @ 400.
	pane := Morph new.
	pane color: Color white.
	browser := (self on: anRMapMorph) buildOn: pane.
	window
		addMorph: pane
		fullFrame: ((0 @ 0 corner: 1 @ 1) asLayoutFrame
				 bottomOffset: -20;
				 yourself).
	window
		addMorph: ((SimpleButtonMorph newWithLabel: 'OK')
				 target: [ window close ];
				 actionSelector: #value;
				 color: Color white;
				 yourself)
		fullFrame: ((1 @ 1 corner: 1 @ 1) asLayoutFrame
				 topOffset: -20;
				 leftOffset: -200;
				 rightOffset: -100;
				 yourself).
	window
		addMorph: ((SimpleButtonMorph newWithLabel: 'Cancel')
				 target: [
					 browser cancel.
					 window close ];
				 actionSelector: #value;
				 color: Color white;
				 yourself)
		fullFrame: ((1 @ 1 corner: 1 @ 1) asLayoutFrame
				 topOffset: -20;
				 leftOffset: -100;
				 yourself).
	(SystemWindow topWindow ifNil: [ World ]) openModal: window.
	^ browser
]

{ #category : #utilities }
RMapScratchingBrowser class >> openOn: anRMapMorph [
	| window |
	window := SystemWindow new.
	(self on: anRMapMorph) buildOn: window.
	window openInWorld.
	^ window
]

{ #category : #'interface building' }
RMapScratchingBrowser >> buildOn: aMorph [

	| listWidth |
	listWidth := RMapVertexListItem width + 18.
	aMorph changeProportionalLayout.
	aMorph
		addMorph: (scratcherMorph := RMapMoleculeScratcherMorph new)
		fullFrame: ((0 @ 0 corner: 1 @ 1) asLayoutFrame
				 rightOffset: listWidth negated;
				 bottomOffset: -100).
	aMorph
		addMorph: (periodicTableMorph := JunPeriodicTableMorph new
				                       selectedAtom: JunCarbon;
				                       action: [ :atomClass |
					                       scratcherMorph defaultAtomClass: atomClass ];
				                       yourself)
		fullFrame: ((0 @ 1 corner: 1 @ 1) asLayoutFrame
				 rightOffset: listWidth negated;
				 topOffset: -100).
	aMorph
		addMorph: ((sortByEnergyCheckbox := CheckboxMorph
				                          on: self
				                          selected: #sortByEnergy
				                          changeSelected: #sortByEnergy:)
				 label: 'sort by energy';
				 yourself)
		fullFrame: ((1 @ 0 corner: 1 @ 0) asLayoutFrame
				 leftOffset: listWidth negated;
				 rightOffset: -150;
				 bottomOffset: 20;
				 yourself).
	aMorph
		addMorph:
			((searchButton := SimpleButtonMorph newWithLabel: 'Search')
				 target: self;
				 actionSelector: #search;
				 color: Color white;
				 yourself)
		fullFrame: ((1 @ 0 corner: 1 @ 0) asLayoutFrame
				 leftOffset: listWidth negated // 2;
				 bottomOffset: 20;
				 yourself).
	aMorph
		addMorph: (listMorph := (RMapPluggableVertexListMorph
				               on: self
				               list: #moleculeList
				               primarySelection: #primarySelectionIndex
				               changePrimarySelection: #primarySelectionIndex:
				               listSelection: #listSelectionAt:
				               changeListSelection: #listSelectionAt:put:
				               menu: #moleculeListMenu:)
				              beMultipleSelection;
				              wrapSelector: #asListItem;
				              yourself)
		fullFrame: ((1 @ 0 corner: 1 @ 1) asLayoutFrame
				 topOffset: 20;
				 leftOffset: listWidth negated;
				 yourself)
]

{ #category : #operations }
RMapScratchingBrowser >> cancel [
	listSelection := nil
]

{ #category : #private }
RMapScratchingBrowser >> inchi [
	^ (JunBabelWrapper convert: scratcherMorph moleculeGeometry asXYZString from: 'xyz' to: 'inchi') trim
		ifNotEmpty: [ :inchi | inchi copyFrom: (inchi indexOf: $=) + 1 to: inchi size ]
]

{ #category : #'initialize-release' }
RMapScratchingBrowser >> initialize [
	primarySelectionIndex := 0.
	listSelection := Set new.
	sortByEnergy := true
]

{ #category : #accessing }
RMapScratchingBrowser >> listSelectionAt: anInteger [
	^ listSelection includes: anInteger
]

{ #category : #accessing }
RMapScratchingBrowser >> listSelectionAt: anInteger put: aBoolean [
	aBoolean
		ifTrue: [ listSelection add: anInteger ]
		ifFalse: [ listSelection remove: anInteger ifAbsent: [  ] ]
]

{ #category : #private }
RMapScratchingBrowser >> molString [
	^ String
		new: 0
		streamContents: [ :stream | 
			| printInt printFloat molecule |
			printInt := [ :int | int printString padLeftTo: 3 ].
			printFloat := [ :float | (float printShowingDecimalPlaces: 4) padLeftTo: 10 ].
			molecule := scratcherMorph moleculeGeometry.
			stream
				cr;
				nextPutAll: 'generated by Jun4Pharo';
				cr;
				cr.
			stream
				nextPutAll: (printInt value: molecule numberOfAtoms);
				nextPutAll: (printInt value: molecule numberOfBonds);
				nextPutAll: (printInt value: 0);
				nextPutAll: (printInt value: 0);
				nextPutAll: (printInt value: 1);
				nextPutAll: (printInt value: 0);
				nextPutAll: (printInt value: 0);
				nextPutAll: (printInt value: 0);
				nextPutAll: (printInt value: 0);
				nextPutAll: (printInt value: 0);
				nextPutAll: (printInt value: 1);
				nextPutAll: ' V2000';
				cr.
			molecule
				atomsDo: [ :atom | 
					stream
						nextPutAll: (printFloat value: atom position x);
						nextPutAll: (printFloat value: atom position y);
						nextPutAll: (printFloat value: atom position z);
						nextPutAll: (atom symbol padLeftTo: 3);
						nextPutAll: ' 0';
						nextPutAll: '  0';
						nextPutAll: '  0';
						nextPutAll: '  1';
						nextPutAll: '  0';
						nextPutAll: '  0';
						nextPutAll: '  0';
						nextPutAll: '   ';
						nextPutAll: '   ';
						nextPutAll: '  1';
						nextPutAll: '  0';
						nextPutAll: '  0';
						cr ].
			molecule
				bondsDo: [ :bond | 
					stream
						nextPutAll: (printInt value: (molecule indexOfAtom: bond atom1));
						nextPutAll: (printInt value: (molecule indexOfAtom: bond atom2));
						nextPutAll: (printInt value: bond order);
						nextPutAll:
								(bond order = 1
										ifTrue: [ 
											printInt
												value:
													(bond wedge = #flat
														ifTrue: [ 0 ]
														ifFalse: [ 
															bond wedge = #up
																ifTrue: [ 1 ]
																ifFalse: [ 
																	bond wedge = #down
																		ifTrue: [ 6 ]
																		ifFalse: [ 4 ] ] ]) ]
										ifFalse: [ printInt value: 0 ]);
						nextPutAll: '   ';
						nextPutAll: (printInt value: 0);
						nextPutAll: (printInt value: 0);
						cr ].
			stream
				nextPutAll: 'M END';
				cr;
				nextPutAll: '$$$$';
				cr ]
]

{ #category : #accessing }
RMapScratchingBrowser >> moleculeList [
	^ moleculeList
]

{ #category : #menu }
RMapScratchingBrowser >> moleculeListMenu: aMenu [

	primarySelectionIndex > 0 ifTrue: [
		| v |
		v := moleculeList at: primarySelectionIndex.
		aMenu addTitle: v label.
		((rmap hasProduct: v) or: [
			 (rmap hasReactant: v) or: [ rmap hasSelection: v ] ]) ifTrue: [
			aMenu
				add: 'unselect' translated
				target: rmap
				selector: #unselect:
				argument: v ].
		(rmap hasSelection: v) ifFalse: [
			aMenu
				add: 'select' translated
				target: rmap
				selector: #addSelection:
				argument: v ].
		(rmap hasReactant: v) ifFalse: [
			aMenu
				add: 'reactant' translated
				target: rmap
				selector: #addReactant:
				argument: v ].
		(rmap hasProduct: v) ifFalse: [
			aMenu
				add: 'product' translated
				target: rmap
				selector: #addProduct:
				argument: v ].
		aMenu
			addLine;
			add: 'open info' translated target: v selector: #openInfo;
			add: 'open in 3D viewer' translated target: v selector: #openJmol;
			add: 'open measure viewer' translated
			target: v
			selector: #openMeasureViewer ].
	^ aMenu
]

{ #category : #menu }
RMapScratchingBrowser >> moleculeListMenu: aMenu shifted: shifted [ 
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
]

{ #category : #accessing }
RMapScratchingBrowser >> primarySelectionIndex [
	^ primarySelectionIndex
]

{ #category : #accessing }
RMapScratchingBrowser >> primarySelectionIndex: anInteger [
	primarySelectionIndex := anInteger
]

{ #category : #operations }
RMapScratchingBrowser >> search [
	| keyMolecule |
	keyMolecule := scratcherMorph moleculeGeometry.
	moleculeList := (rmap vertices select: [ :vertex | keyMolecule isSubstructureOf: vertex asMolecule ])
		asSortedCollection: [ :v1 :v2 | v1 energy <= v2 energy ].
	self sortMoleculeList
]

{ #category : #accessing }
RMapScratchingBrowser >> selections [
	^ listSelection ifNotNil: [ listSelection asSortedCollection collect: [ :index | moleculeList at: index ] ]
]

{ #category : #private }
RMapScratchingBrowser >> setRMap: anRMapMorph [
	rmap := anRMapMorph.
	moleculeList := Array withAll: (anRMapMorph vertices asSortedCollection: [ :v1 :v2 | v1 energy <= v2 energy ])
]

{ #category : #private }
RMapScratchingBrowser >> smiles [
	^ (JunBabelWrapper convert: scratcherMorph moleculeGeometry asXYZString from: 'xyz' to: 'can') trim
]

{ #category : #accessing }
RMapScratchingBrowser >> sortByEnergy [
	^ false ~~ sortByEnergy
]

{ #category : #accessing }
RMapScratchingBrowser >> sortByEnergy: aBoolean [
	sortByEnergy := aBoolean ~~ false.
	self sortMoleculeList
]

{ #category : #operations }
RMapScratchingBrowser >> sortMoleculeList [
	moleculeList := self sortByEnergy
		ifTrue: [ moleculeList asSortedCollection: [ :v1 :v2 | v1 energy <= v2 energy ] ]
		ifFalse: [ 
			| keySignature errors |
			keySignature := scratcherMorph moleculeGeometry fullShapeSignatureWithBondCorrection.
			errors := OrderedCollection new: moleculeList size.
			moleculeList
				do: [ :vertex | 
					| signature error |
					signature := vertex fullShapeSignature.
					error := 0.0.
					keySignature
						keysAndValuesDo: [ :atoms :distances1 | 
							signature
								at: atoms
								ifPresent: [ :distances2 | 
									1 to: (distances1 size min: distances2 size) do: [ :i | 
										| d1 d2 |
										d1 := distances1 at: i.
										d2 := distances2 at: i.
										error := (d1 - d2) abs / (d1 max: d2) + error ].
									error := (distances1 size - distances2 size) abs + error ]
								ifAbsent: [ error := distances1 size + error ] ].
					signature
						keysAndValuesDo: [ :atoms :distances2 | keySignature at: atoms ifAbsent: [ error := distances2 size + error ] ].
					errors add: error -> vertex ].
			errors asSortedCollection collect: #value ].
	primarySelectionIndex := 0.
	listSelection := Set new.
	self changed: #moleculeList.
	self changed: #listSelection.
	self changed: #primarySelectionIndex
]
