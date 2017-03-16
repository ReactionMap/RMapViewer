user interface
searchBox
	|  holder entryField |
	holder := StringHolder new.
	entryField := PluggableTextFieldMorph on: holder text: #contents accept: #contents:.
	entryField autoAccept: true.
	entryField alwaysAccept: true.
	entryField acceptOnCR: true.
	entryField acceptOnFocusChange: true.
	entryField styled: false.
	entryField hideVScrollBarIndefinitely: true.
	entryField crAction: [:t | self search: t asString. entryField hasUnacceptedEdits: false ].
	^ entryField