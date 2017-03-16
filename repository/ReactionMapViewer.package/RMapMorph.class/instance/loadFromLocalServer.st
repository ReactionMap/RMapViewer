private
loadFromLocalServer
	| server rmaps index |
	server := (Smalltalk at: #RMapServer ifAbsent: [ ^ self ]) current.
	rmaps := server selectMeta: Dictionary new.
	index := UIManager default chooseFrom: (rmaps collect: [ :rmap | ((rmap at: 'meta') at: 'name') allButLast: 5 ]).
	index = 0
		ifTrue: [ ^ self ].
	self load: (server at: ((rmaps at: index) at: '_id'))