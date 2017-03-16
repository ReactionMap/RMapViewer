enumerating
markedVerticesDo: aBlock
	self selectedVerticesDo: aBlock.
	self reactantsDo: aBlock.
	self productsDo: aBlock