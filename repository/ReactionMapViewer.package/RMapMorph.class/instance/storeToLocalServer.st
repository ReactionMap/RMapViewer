private
storeToLocalServer
	| server rmapName |
	server := (Smalltalk at: #RMapServer ifAbsent: [ ^ self ]) current.
	rmapName := UIManager default request: 'Please provide a name'.
	rmapName isNil
		ifTrue: [ ^ self ].
	rmapName := rmapName trim.
	rmapName isEmpty
		ifTrue: [ ^ self ].
	(rmapName endsWith: '.rmap')
		ifFalse: [ rmapName := rmapName , '.rmap' ].
	server
		add: self createJSON
		named: rmapName
		ifFailed: [ :msg | 
			UIManager abort: msg.
			^ self ]