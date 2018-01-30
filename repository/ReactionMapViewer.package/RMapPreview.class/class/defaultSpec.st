specs
defaultSpec
	<script: 'RMapPreview new openDialogWithSpec title: ''Vertex Preview'''>
	<spec>
	^ SpecLayout composed
		newColumn: [ :c | 
					c
						add: #nameLabel height: 20;
						add: #componentsLabel height: 20;
						add: #vertexList;
						yourself ];
		yourself