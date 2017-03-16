accessing
peer: eq
	^ eq == eq1
		ifTrue: [ eq2 ]
		ifFalse: [ eq1 ]