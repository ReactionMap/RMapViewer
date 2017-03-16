accessing
formFor: anRMapVertex
	| forms |
	forms := anRMapVertex formsIfAbsentPut: [ self formsFor: anRMapVertex ].
	^forms at: step \\ forms size + 1