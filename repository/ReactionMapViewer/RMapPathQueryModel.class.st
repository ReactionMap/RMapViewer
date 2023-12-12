"
I represent the user interface to choose reactants and products.
I accept new search results and keep it as ""free"" nodes.
The user can move some of them to reactant nodes or product nodes, and vice versa.
"
Class {
	#name : #RMapPathQueryModel,
	#superclass : #Model,
	#instVars : [
		'freeList',
		'freeSelection',
		'freePrimaryIndex',
		'reactantList',
		'reactantSelection',
		'reactantPrimaryIndex',
		'productList',
		'productSelection',
		'productPrimaryIndex'
	],
	#category : #'ReactionMapViewer-Support'
}

{ #category : #accessing }
RMapPathQueryModel class >> preferredWidth [
	^ 400
]

{ #category : #operations }
RMapPathQueryModel >> addAndSelectAll: aCollectionOfRMapVertex [
	| freeSelectionItems reactantSelectionItems productSelectionItems |
	freeSelectionItems := Set new.
	reactantSelectionItems := Set new.
	productSelectionItems := Set new.
	freePrimaryIndex := 0.
	reactantPrimaryIndex := 0.
	productPrimaryIndex := 0.
	aCollectionOfRMapVertex
		do: [ :vertex | 
			(freeList includes: vertex)
				ifTrue: [ freeSelectionItems add: vertex.
					freePrimaryIndex := freeList indexOf: vertex ]
				ifFalse: [ (reactantList includes: vertex)
						ifTrue: [ reactantSelectionItems add: vertex.
							reactantPrimaryIndex := reactantList indexOf: vertex ]
						ifFalse: [ (productList includes: vertex)
								ifTrue: [ productSelectionItems add: vertex.
									productPrimaryIndex := productList indexOf: vertex ]
								ifFalse: [ freeList add: vertex.
									freeSelectionItems add: vertex.
									freePrimaryIndex := freeList indexOf: vertex ] ] ] ].
	freeSelection := freeSelectionItems
		collect: [ :item | freeList indexOf: item ].
	reactantSelection := reactantSelectionItems
		collect: [ :item | reactantList indexOf: item ].
	productSelection := productSelectionItems
		collect: [ :item | productList indexOf: item ].
	self changed: #freeList.
	self pathQueryChanged.
	^ aCollectionOfRMapVertex
]

{ #category : #operations }
RMapPathQueryModel >> addFree: anRMapVertex [
	| freeSelectionItems reactantSelectionItems productSelectionItems reactantListChanged productListChanged |
	freeSelectionItems := Set new.
	reactantSelectionItems := Set new.
	productSelectionItems := Set new.
	freePrimaryIndex := 0.
	reactantPrimaryIndex := 0.
	productPrimaryIndex := 0.
	(freeList includes: anRMapVertex)
		ifFalse: [ freeList add: anRMapVertex ].
	reactantListChanged := (reactantList
		remove: anRMapVertex
		ifAbsent: [ nil ]) notNil.
	productListChanged := (productList
		remove: anRMapVertex
		ifAbsent: [ nil ]) notNil.
	freeSelection := freeSelectionItems
		collect: [ :item | freeList indexOf: item ].
	reactantSelection := reactantSelectionItems
		collect: [ :item | reactantList indexOf: item ].
	productSelection := productSelectionItems
		collect: [ :item | productList indexOf: item ].
	self changed: #freeList.
	self changed: #reactantList.
	self changed: #productList.
	(reactantListChanged or: [ productListChanged ])
		ifTrue: [ self pathQueryChanged ]
]

{ #category : #operations }
RMapPathQueryModel >> addProduct: anRMapVertex [
	| freeSelectionItems reactantSelectionItems productSelectionItems reactantListChanged productListChanged |
	freeSelectionItems := Set new.
	reactantSelectionItems := Set new.
	productSelectionItems := Set new.
	freePrimaryIndex := 0.
	reactantPrimaryIndex := 0.
	productPrimaryIndex := 0.
	freeList remove: anRMapVertex ifAbsent: [ nil ].
	reactantListChanged := (reactantList
		remove: anRMapVertex
		ifAbsent: [ nil ]) notNil.
	(productListChanged := (productList includes: anRMapVertex) not)
		ifTrue: [ productList add: anRMapVertex ].
	freeSelection := freeSelectionItems
		collect: [ :item | freeList indexOf: item ].
	reactantSelection := reactantSelectionItems
		collect: [ :item | reactantList indexOf: item ].
	productSelection := productSelectionItems
		collect: [ :item | productList indexOf: item ].
	self changed: #freeList.
	self changed: #reactantList.
	self changed: #productList.
	(reactantListChanged or: [ productListChanged ])
		ifTrue: [ self pathQueryChanged ]
]

{ #category : #operations }
RMapPathQueryModel >> addReactant: anRMapVertex [
	| freeSelectionItems reactantSelectionItems productSelectionItems reactantListChanged productListChanged |
	freeSelectionItems := Set new.
	reactantSelectionItems := Set new.
	productSelectionItems := Set new.
	freePrimaryIndex := 0.
	reactantPrimaryIndex := 0.
	productPrimaryIndex := 0.
	freeList remove: anRMapVertex ifAbsent: [ nil ].
	(reactantListChanged := (reactantList includes: anRMapVertex) not)
		ifTrue: [ reactantList add: anRMapVertex ].
	productListChanged := (productList
		remove: anRMapVertex
		ifAbsent: [ nil ]) notNil.
	freeSelection := freeSelectionItems
		collect: [ :item | freeList indexOf: item ].
	reactantSelection := reactantSelectionItems
		collect: [ :item | reactantList indexOf: item ].
	productSelection := productSelectionItems
		collect: [ :item | productList indexOf: item ].
	self changed: #freeList.
	self changed: #reactantList.
	self changed: #productList.
	(reactantListChanged or: [ productListChanged ])
		ifTrue: [ self pathQueryChanged ]
]

{ #category : #'interface building' }
RMapPathQueryModel >> buildOn: aMorph [
	aMorph
		changeProportionalLayout;
		addMorph: self freeListPane
			fullFrame:
			(LayoutFrame identity
				rightFraction: 0.45;
				yourself);
		addMorph:
			((SimpleButtonMorph newWithLabel: '>')
				target: self;
				actionSelector: #moveSelectedFreeToReactant;
				color: Color white;
				yourself)
			fullFrame:
			(LayoutFrame identity
					leftFraction: 0.45;
					rightFraction: 0.55;
					topFraction: 0.25;
					bottomFraction: 0.25;
					topOffset: -20;
					bottomOffset: -1;
					yourself);
		addMorph:
			((SimpleButtonMorph newWithLabel: '<')
				target: self;
				actionSelector: #moveSelectedReactantToFree;
				color: Color white;
				yourself)
			fullFrame:
			(LayoutFrame identity
					leftFraction: 0.45;
					rightFraction: 0.55;
					topFraction: 0.25;
					bottomFraction: 0.25;
					topOffset: 1;
					bottomOffset: 20;
					yourself);
		addMorph: self reactantListPane
			fullFrame:
			(LayoutFrame identity
				leftFraction: 0.55;
				bottomFraction: 0.5;
				yourself);
		addMorph:
			((SimpleButtonMorph newWithLabel: '>')
				target: self;
				actionSelector: #moveSelectedFreeToProduct;
				color: Color white;
				yourself)
			fullFrame:
			(LayoutFrame identity
					leftFraction: 0.45;
					rightFraction: 0.55;
					topFraction: 0.75;
					bottomFraction: 0.75;
					topOffset: -20;
					bottomOffset: -1;
					yourself);
		addMorph:
			((SimpleButtonMorph newWithLabel: '<')
				target: self;
				actionSelector: #moveSelectedProductToFree;
				color: Color white;
				yourself)
			fullFrame:
			(LayoutFrame identity
					leftFraction: 0.45;
					rightFraction: 0.55;
					topFraction: 0.75;
					bottomFraction: 0.75;
					topOffset: 1;
					bottomOffset: 20;
					yourself);
		addMorph: self productListPane
			fullFrame:
			(LayoutFrame identity
				topFraction: 0.5;
				leftFraction: 0.55;
				yourself)
]

{ #category : #icons }
RMapPathQueryModel >> deleteIcon [
	^ Smalltalk ui icons
		iconNamed: #remove
		ifNone: [ Smalltalk ui icons
				iconNamed: #delete
				ifNone: [ | form |
					form := Form extent: 20 @ 20 depth: 32.
					form getCanvas
						fillColor: (Color gray: 0.8);
						drawString: 'd' at: 5 @ 2.
					form ] ]
]

{ #category : #operations }
RMapPathQueryModel >> deleteSelectedFree [
	freeSelection ifEmpty: [ ^ self ].
	freeList
		removeAll: (freeSelection collect: [ :index | freeList at: index ]).
	freeSelection removeAll.
	freePrimaryIndex := 0.
	self changed: #freeList.
	self pathQueryChanged
]

{ #category : #operations }
RMapPathQueryModel >> deleteSelectedProduct [
	productSelection ifEmpty: [ ^ self ].
	productList
		removeAll: (productSelection collect: [ :index | productList at: index ]).
	productSelection removeAll.
	productPrimaryIndex := 0.
	self changed: #productList.
	self pathQueryChanged
]

{ #category : #operations }
RMapPathQueryModel >> deleteSelectedReactant [
	reactantSelection ifEmpty: [ ^ self ].
	reactantList
		removeAll: (reactantSelection collect: [ :index | reactantList at: index ]).
	reactantSelection removeAll.
	reactantPrimaryIndex := 0.
	self changed: #reactantList.
	self pathQueryChanged
]

{ #category : #accessing }
RMapPathQueryModel >> freeList [
	^ freeList
]

{ #category : #'interface building' }
RMapPathQueryModel >> freeListPane [

	^ Morph new
		  color: Color white;
		  changeProportionalLayout;
		  addMorph: (RMapLabelMorph contents: 'Selection')
		  fullFrame: (LayoutFrame identity
				   bottomFraction: 0;
				   bottomOffset: 20;
				   rightOffset: -40;
				   yourself);
		  addMorph:
			  ((IconicButtonMorph new graphicalMorph:
					    self unselectAllIcon asMorph)
				   target: self;
				   actionSelector: #unselectAllFree;
				   color: Color white;
				   borderNormal;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   leftFraction: 1;
				   bottomFraction: 0;
				   leftOffset: -60;
				   rightOffset: -40;
				   topOffset: 2;
				   bottomOffset: 20;
				   yourself);
		  addMorph:
			  ((IconicButtonMorph new graphicalMorph:
					    self selectAllIcon asMorph)
				   target: self;
				   actionSelector: #selectAllFree;
				   color: Color white;
				   borderNormal;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   leftFraction: 1;
				   bottomFraction: 0;
				   leftOffset: -40;
				   rightOffset: -20;
				   topOffset: 2;
				   bottomOffset: 20;
				   yourself);
		  addMorph:
			  ((IconicButtonMorph new graphicalMorph: self deleteIcon asMorph)
				   target: self;
				   actionSelector: #deleteSelectedFree;
				   color: Color white;
				   borderNormal;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   leftFraction: 1;
				   bottomFraction: 0.0;
				   topOffset: 2;
				   leftOffset: -20;
				   bottomOffset: 20;
				   yourself);
		  addMorph: ((RMapPluggableVertexListMorph
				    on: self
				    list: #freeList
				    primarySelection: #freePrimaryIndex
				    changePrimarySelection: #freePrimaryIndex:
				    listSelection: #freeSelectionAt:
				    changeListSelection: #freeSelectionAt:put:
				    menu: nil)
				   wrapSelector: #asListItem;
				   borderWidth: 2;
				   borderColor: Color black;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   topOffset: 20;
				   yourself);
		  yourself
]

{ #category : #accessing }
RMapPathQueryModel >> freePrimaryIndex [
	^ freePrimaryIndex
]

{ #category : #accessing }
RMapPathQueryModel >> freePrimaryIndex: anInteger [
	freePrimaryIndex := anInteger
]

{ #category : #accessing }
RMapPathQueryModel >> freeSelectionAt: anInteger [
	^ freeSelection includes: anInteger
]

{ #category : #accessing }
RMapPathQueryModel >> freeSelectionAt: anInteger put: aBoolean [
	aBoolean
		ifTrue: [ freeSelection add: anInteger ]
		ifFalse: [ freeSelection remove: anInteger ifAbsent: [  ] ]
]

{ #category : #testing }
RMapPathQueryModel >> includes: anRMapVertex [
	^ (freeList includes: anRMapVertex)
		or: [ (reactantList includes: anRMapVertex)
				or: [ productList includes: anRMapVertex ] ]
]

{ #category : #'initialize-release' }
RMapPathQueryModel >> initialize [
	super initialize.
	freeList := SortedCollection
		sortBlock: [ :less :more | less energy <= more energy ].
	reactantList := SortedCollection
		sortBlock: [ :less :more | less energy <= more energy ].
	productList := SortedCollection
		sortBlock: [ :less :more | less energy <= more energy ].
	freeSelection := Set new.
	reactantSelection := Set new.
	productSelection := Set new.
	freePrimaryIndex := 0.
	reactantPrimaryIndex := 0.
	productPrimaryIndex := 0
]

{ #category : #testing }
RMapPathQueryModel >> isEmpty [
	^ freeList isEmpty
		and: [ reactantList isEmpty and: [ productList isEmpty ] ]
]

{ #category : #operations }
RMapPathQueryModel >> moveSelectedFreeToProduct [
	| movingItems |
	movingItems := freeSelection asArray
		collect: [ :index | freeList at: index ].
	movingItems ifEmpty: [ ^ self ].
	freeList removeAll: movingItems.
	freeSelection removeAll.
	freePrimaryIndex := 0.
	productList addAll: movingItems.
	productSelection
		removeAll;
		addAll: (movingItems collect: [ :item | productList indexOf: item ]).
	productPrimaryIndex := 0.
	self
		changed: #freeList;
		changed: #productList.
	self pathQueryChanged
]

{ #category : #operations }
RMapPathQueryModel >> moveSelectedFreeToReactant [
	| movingItems |
	movingItems := freeSelection asArray
		collect: [ :index | freeList at: index ].
	movingItems ifEmpty: [ ^ self ].
	freeList removeAll: movingItems.
	freeSelection removeAll.
	freePrimaryIndex := 0.
	reactantList addAll: movingItems.
	reactantSelection
		removeAll;
		addAll: (movingItems collect: [ :item | reactantList indexOf: item ]).
	reactantPrimaryIndex := 0.
	self
		changed: #freeList;
		changed: #reactantList.
	self pathQueryChanged
]

{ #category : #operations }
RMapPathQueryModel >> moveSelectedProductToFree [
	| movingItems |
	movingItems := productSelection asArray
		collect: [ :index | productList at: index ].
	movingItems ifEmpty: [ ^ self ].
	productList removeAll: movingItems.
	productSelection removeAll.
	productPrimaryIndex := 0.
	freeList addAll: movingItems.
	freeSelection
		removeAll;
		addAll: (movingItems collect: [ :item | freeList indexOf: item ]).
	freePrimaryIndex := 0.
	self
		changed: #freeList;
		changed: #productList.
	self pathQueryChanged
]

{ #category : #operations }
RMapPathQueryModel >> moveSelectedReactantToFree [
	| movingItems |
	movingItems := reactantSelection asArray
		collect: [ :index | reactantList at: index ].
	movingItems ifEmpty: [ ^ self ].
	reactantList removeAll: movingItems.
	reactantSelection removeAll.
	reactantPrimaryIndex := 0.
	freeList addAll: movingItems.
	freeSelection
		removeAll;
		addAll: (movingItems collect: [ :item | freeList indexOf: item ]).
	freePrimaryIndex := 0.
	self
		changed: #freeList;
		changed: #reactantList.
	self pathQueryChanged
]

{ #category : #announcements }
RMapPathQueryModel >> onPathQueryChangeSend: aSelector to: anObject [
	self announcer
		when: self pathQueryChangedAnnouncement
		send: aSelector
		to: anObject
]

{ #category : #announcements }
RMapPathQueryModel >> pathQueryChanged [
	self announcer announce: self pathQueryChangedAnnouncement new
]

{ #category : #announcements }
RMapPathQueryModel >> pathQueryChangedAnnouncement [
	^ RMapPathQueryChangedAnnouncement
]

{ #category : #accessing }
RMapPathQueryModel >> productList [
	^ productList
]

{ #category : #'interface building' }
RMapPathQueryModel >> productListPane [

	^ Morph new
		  color: Color white;
		  changeProportionalLayout;
		  addMorph: (RMapLabelMorph contents: 'Product')
		  fullFrame: (LayoutFrame identity
				   bottomFraction: 0;
				   bottomOffset: 20;
				   rightOffset: -40;
				   yourself);
		  addMorph:
			  ((IconicButtonMorph new graphicalMorph:
					    self unselectAllIcon asMorph)
				   target: self;
				   actionSelector: #unselectAllProduct;
				   color: Color white;
				   borderNormal;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   leftFraction: 1;
				   bottomFraction: 0;
				   leftOffset: -60;
				   rightOffset: -40;
				   topOffset: 2;
				   bottomOffset: 20;
				   yourself);
		  addMorph:
			  ((IconicButtonMorph new graphicalMorph:
					    self selectAllIcon asMorph)
				   target: self;
				   actionSelector: #selectAllProduct;
				   color: Color white;
				   borderNormal;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   leftFraction: 1;
				   bottomFraction: 0;
				   leftOffset: -40;
				   rightOffset: -20;
				   topOffset: 2;
				   bottomOffset: 20;
				   yourself);
		  addMorph:
			  ((IconicButtonMorph new graphicalMorph: self deleteIcon asMorph)
				   target: self;
				   actionSelector: #deleteSelectedProduct;
				   color: Color white;
				   borderNormal;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   leftFraction: 1;
				   bottomFraction: 0.0;
				   topOffset: 2;
				   leftOffset: -20;
				   bottomOffset: 20;
				   yourself);
		  addMorph: ((RMapPluggableVertexListMorph
				    on: self
				    list: #productList
				    primarySelection: #productPrimaryIndex
				    changePrimarySelection: #productPrimaryIndex:
				    listSelection: #productSelectionAt:
				    changeListSelection: #productSelectionAt:put:
				    menu: nil)
				   wrapSelector: #asListItem;
				   borderWidth: 2;
				   borderColor: Color black;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   topOffset: 20;
				   yourself);
		  yourself
]

{ #category : #accessing }
RMapPathQueryModel >> productPrimaryIndex [
	^ productPrimaryIndex
]

{ #category : #accessing }
RMapPathQueryModel >> productPrimaryIndex: anInteger [
	productPrimaryIndex := anInteger
]

{ #category : #accessing }
RMapPathQueryModel >> productSelectionAt: anInteger [
	^ productSelection includes: anInteger
]

{ #category : #accessing }
RMapPathQueryModel >> productSelectionAt: anInteger put: aBoolean [
	aBoolean
		ifTrue: [ productSelection add: anInteger ]
		ifFalse: [ productSelection remove: anInteger ifAbsent: [  ] ]
]

{ #category : #accessing }
RMapPathQueryModel >> reactantList [
	^ reactantList
]

{ #category : #'interface building' }
RMapPathQueryModel >> reactantListPane [

	^ Morph new
		  color: Color white;
		  changeProportionalLayout;
		  addMorph: (RMapLabelMorph contents: 'Reactant')
		  fullFrame: (LayoutFrame identity
				   bottomFraction: 0;
				   bottomOffset: 20;
				   rightOffset: -40;
				   yourself);
		  addMorph:
			  ((IconicButtonMorph new graphicalMorph:
					    self unselectAllIcon asMorph)
				   target: self;
				   actionSelector: #unselectAllReactant;
				   color: Color white;
				   borderNormal;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   leftFraction: 1;
				   bottomFraction: 0;
				   leftOffset: -60;
				   rightOffset: -40;
				   topOffset: 2;
				   bottomOffset: 20;
				   yourself);
		  addMorph:
			  ((IconicButtonMorph new graphicalMorph:
					    self selectAllIcon asMorph)
				   target: self;
				   actionSelector: #selectAllReactant;
				   color: Color white;
				   borderNormal;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   leftFraction: 1;
				   bottomFraction: 0;
				   leftOffset: -40;
				   rightOffset: -20;
				   topOffset: 2;
				   bottomOffset: 20;
				   yourself);
		  addMorph:
			  ((IconicButtonMorph new graphicalMorph: self deleteIcon asMorph)
				   target: self;
				   actionSelector: #deleteSelectedReactant;
				   color: Color white;
				   borderNormal;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   leftFraction: 1;
				   bottomFraction: 0.0;
				   topOffset: 2;
				   leftOffset: -20;
				   bottomOffset: 20;
				   yourself);
		  addMorph: ((RMapPluggableVertexListMorph
				    on: self
				    list: #reactantList
				    primarySelection: #reactantPrimaryIndex
				    changePrimarySelection: #reactantPrimaryIndex:
				    listSelection: #reactantSelectionAt:
				    changeListSelection: #reactantSelectionAt:put:
				    menu: nil)
				   borderWidth: 2;
				   borderColor: Color black;
				   wrapSelector: #asListItem;
				   yourself)
		  fullFrame: (LayoutFrame identity
				   topOffset: 20;
				   yourself);
		  yourself
]

{ #category : #accessing }
RMapPathQueryModel >> reactantPrimaryIndex [
	^ reactantPrimaryIndex
]

{ #category : #accessing }
RMapPathQueryModel >> reactantPrimaryIndex: anInteger [
	reactantPrimaryIndex := anInteger
]

{ #category : #accessing }
RMapPathQueryModel >> reactantSelection [
	^ reactantSelection
]

{ #category : #accessing }
RMapPathQueryModel >> reactantSelection: anObject [
	reactantSelection := anObject
]

{ #category : #accessing }
RMapPathQueryModel >> reactantSelectionAt: anInteger [
	^ reactantSelection includes: anInteger
]

{ #category : #accessing }
RMapPathQueryModel >> reactantSelectionAt: anInteger put: aBoolean [
	aBoolean
		ifTrue: [ reactantSelection add: anInteger ]
		ifFalse: [ reactantSelection remove: anInteger ifAbsent: [  ] ]
]

{ #category : #operations }
RMapPathQueryModel >> rotateSelection: anRMapVertex [
	(freeList includes: anRMapVertex)
		ifTrue: [ ^ self addReactant: anRMapVertex ].
	(reactantList includes: anRMapVertex)
		ifTrue: [ ^ self addProduct: anRMapVertex ].
	^ self addFree: anRMapVertex
]

{ #category : #operations }
RMapPathQueryModel >> selectAllFree [
	freeSelection := (1 to: freeList size) asSet.
	self changed: #freeList
]

{ #category : #icons }
RMapPathQueryModel >> selectAllIcon [
	^ Smalltalk ui icons
		iconNamed: #checkedBox
		ifNone: [ Smalltalk ui icons
				iconNamed: #checkBoxOn
				ifNone: [ | form |
					form := Form extent: 20 @ 20 depth: 32.
					form getCanvas
						fillColor: (Color gray: 0.8);
						drawString: 'V' at: 5 @ 2.
					form ] ]
]

{ #category : #operations }
RMapPathQueryModel >> selectAllProduct [
	productSelection := (1 to: productList size) asSet.
	self changed: #productList
]

{ #category : #operations }
RMapPathQueryModel >> selectAllReactant [
	reactantSelection := (1 to: reactantList size) asSet.
	self changed: #reactantList
]

{ #category : #operations }
RMapPathQueryModel >> unselect: anRMapVertex [
	| freeSelectionItems reactantSelectionItems productSelectionItems |
	freeSelectionItems := Set new.
	reactantSelectionItems := Set new.
	productSelectionItems := Set new.
	freePrimaryIndex := 0.
	reactantPrimaryIndex := 0.
	productPrimaryIndex := 0.
	freeList remove: anRMapVertex ifAbsent: [ nil ].
	reactantList remove: anRMapVertex ifAbsent: [ nil ].
	productList remove: anRMapVertex ifAbsent: [ nil ].
	freeSelection := freeSelectionItems
		collect: [ :item | freeList indexOf: item ].
	reactantSelection := reactantSelectionItems
		collect: [ :item | reactantList indexOf: item ].
	productSelection := productSelectionItems
		collect: [ :item | productList indexOf: item ].
	self changed: #freeList.
	self changed: #reactantList.
	self changed: #productList.
	self pathQueryChanged
]

{ #category : #operations }
RMapPathQueryModel >> unselectAllFree [
	freeSelection := Set new.
	self changed: #freeList
]

{ #category : #icons }
RMapPathQueryModel >> unselectAllIcon [
	^ Smalltalk ui icons
		iconNamed: #checkBoxOff
		ifNone: [ | form |
			form := Form extent: 20 @ 20 depth: 32.
			form getCanvas
				fillColor: (Color gray: 0.8);
				drawString: 'V' at: 5 @ 2.
			form ]
]

{ #category : #operations }
RMapPathQueryModel >> unselectAllProduct [
	productSelection := Set new.
	self changed: #productList
]

{ #category : #operations }
RMapPathQueryModel >> unselectAllReactant [
	reactantSelection := Set new.
	self changed: #reactantList
]
