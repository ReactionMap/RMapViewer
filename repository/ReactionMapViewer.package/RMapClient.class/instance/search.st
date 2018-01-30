operations
search
	| url query client response |
	url := urlField text asString trim asZnUrl / 'api' / 'search'.
	query := self queryModel query.
	client := ZnClient new
		beOneShot;
		url: url;
		yourself.
	query keysAndValuesDo: [ :key :value | client queryAt: key put: value ].
	client get.
	response := client response.
	response isSuccess
		ifFalse: [ 
			| status |
			status := response status.
			^ UIManager inform: status code printString , ' ' , status reason ].
	rmapList
		items: (NeoJSONReader fromString: response entity string);
		resetSelection