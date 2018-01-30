operations
getRMap: aDictionary
	| url query client response |
	aDictionary ifNil: [ ^ nil ].
	url := urlField text asString trim asZnUrl / 'api' / 'get'.
	query := self queryModel query.
	client := ZnClient new
		beOneShot;
		url: url;
		yourself.
	client queryAt: '_id' put: (aDictionary at: '_id' ifAbsent: [ ^ nil ]).
	client get.
	response := client response.
	^ response isSuccess
		ifTrue: [ NeoJSONReader fromString: response entity string ]
		ifFalse: [ nil ]