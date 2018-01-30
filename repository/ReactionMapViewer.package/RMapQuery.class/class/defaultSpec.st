specs
defaultSpec
	<script: 'RMapQuery new openDialogWithSpec title: ''RMapServer query'''>
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
										yourself ] ]
			width: 300;
		yourself