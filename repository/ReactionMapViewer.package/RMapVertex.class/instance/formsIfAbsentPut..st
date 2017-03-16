accessing
formsIfAbsentPut: aBlock
	^ forms ifNil: [ forms := aBlock cull: self ]