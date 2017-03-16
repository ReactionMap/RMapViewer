accessing
formsFor: anRMapVertex
	^ (anRMapVertex label notNil and: [ anRMapVertex label first = $E ])
		ifTrue: [ super formsFor: anRMapVertex ]
		ifFalse: [self underlineLabelFormsFor: anRMapVertex]