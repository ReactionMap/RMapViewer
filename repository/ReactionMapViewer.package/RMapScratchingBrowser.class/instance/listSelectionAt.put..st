accessing
listSelectionAt: anInteger put: aBoolean
	aBoolean = true
		ifTrue: [ listSelection add: anInteger ]
		ifFalse: [ listSelection remove: anInteger ifAbsent: [  ] ]