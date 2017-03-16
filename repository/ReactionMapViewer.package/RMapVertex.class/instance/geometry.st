accessing
geometry
	^ json at: 'geometry' ifAbsentPut: [ Array new ]