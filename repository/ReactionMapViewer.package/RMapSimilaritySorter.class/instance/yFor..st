accessing
yFor: anRMapVertex
	| index |
	index := (self indexOf: anRMapVertex).
	index <= 0
		ifTrue: [ ^ nil ].
	^  ((self columnSize squared - index // self columnSize) asFloat / self columnSize asFloat)