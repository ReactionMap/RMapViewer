specs
defaultSpec
	<script: 'RMapClient new openWithSpec title: ''RMapClient'''>
	<spec>
	^ SpecLayout composed
		newRow: [ :row | 
					row
						newColumn: [ :c | 
									c
										add: #urlField height: 20;
										add: #queryModel;
										add: #searchButton height: 25;
										yourself ]
							width: 300;
						newColumn: [ :c | 
									c
										add: #rmapList;
										yourself ]
							width: 300;
						newColumn: [ :c | 
									c
										add: #rmapModel;
										add: #openButton height: 25;
										yourself ] ];
		yourself