accessing
label
	^ json at: 'label' ifAbsentPut: [ String new ]