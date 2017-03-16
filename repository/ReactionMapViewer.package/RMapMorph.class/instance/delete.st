private
delete
	searchProcess ifNotNil: [ searchProcess terminate. searchProcess := nil].
	^super delete