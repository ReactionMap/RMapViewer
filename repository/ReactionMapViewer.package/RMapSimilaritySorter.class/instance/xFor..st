accessing
xFor: anRMapVertex
	| index |
	index := (self indexOf: anRMapVertex) - 1.
	index < 0
		ifTrue: [ ^ nil ].
	^ (index \\ self columnSize) asFloat / self columnSize asFloat