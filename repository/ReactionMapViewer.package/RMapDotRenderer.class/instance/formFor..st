accessing
formFor: anRMapVertex
	^ anRMapVertex isEQ
		ifTrue: [ self blackForm ]
		ifFalse: [ self grayForm ]