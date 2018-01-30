initialization
initializeWidgets
	nameLabel := self newLabel.
	componentsLabel := self newLabel.
	vertexList := self newIconList
		displayBlock: [ :vertex | vertex label , ' ' , vertex kJpermolAboveBaselineString ];
		icons: [ :vertex | vertex asFormExtent: 100 @ 100 ];
		whenSelectedItemChanged: [ :vertex | vertex ifNotNil: #openJmol];
		yourself.
	self updateRMap