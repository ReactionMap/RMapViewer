specs
defaultSpec
	<spec>
	^ SpecLayout composed
		newColumn: [ :c | 
					c
						newRow: [ :r | 
									r
										add: #nameField;
										yourself ]
							height: 20;
						newRow: [ :r | 
									r
										add: #commandField;
										add: #methodField;
										add: #basisField;
										yourself ]
							height: 20;
						newRow: [ :r | 
									r
										add: #compositionTable;
										yourself ] ];
		yourself