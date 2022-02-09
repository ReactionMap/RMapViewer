Class {
	#name : #RMapDistanceDataSource,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'distances',
		'rmap'
	],
	#category : #'ReactionMapViewer-Morphs'
}

{ #category : #'instance creation' }
RMapDistanceDataSource class >> openOn: aRMapVertex withAll: aCollectionOfRMapVertex rmap: aRMapMorph [

	^ (self new
		   rmap: aRMapMorph;
		   distances: (aCollectionOfRMapVertex
				    with: (GRMSD new
						     distanceFrom: aRMapVertex asMolecule
						     withAll: (aCollectionOfRMapVertex collect: #asMolecule))
				    collect: [ :vertex :distance | vertex -> distance ])
				   asDictionary;
		   yourself) openInWindowLabeled:
		  'Distance from ' , aRMapVertex label
]

{ #category : #accessing }
RMapDistanceDataSource >> cellColumn: column row: rowIndex [

	column id = 'label' ifTrue: [ 
		^ self labelColumn: column row: rowIndex ].
	column id = 'distance' ifTrue: [ 
		^ self distanceColumn: column row: rowIndex ].
	column id = 'energy' ifTrue: [ 
		^ self energyColumn: column row: rowIndex ].
	column id = 'model' ifTrue: [ 
		^ self modelColumn: column row: rowIndex ].

	self error: 'Invalid column'
]

{ #category : #accessing }
RMapDistanceDataSource >> distanceColumn: column row: rowIndex [

	^ FTCellMorph new
		  addMorphBack: (distances
				   at: (self elementAt: rowIndex)
				   ifPresent: [ :distance | distance printShowingDecimalPlaces: 3 ]
				   ifAbsent: [ '' ]) asStringMorph;
		  listCentering: #center;
		  yourself
]

{ #category : #accessing }
RMapDistanceDataSource >> distances: aDictionary [

	distances := aDictionary.
	self elements: (distances keys sorted: [ :less :more | 
			 (distances at: less) <= (distances at: more) ])
]

{ #category : #accessing }
RMapDistanceDataSource >> energyColumn: column row: rowIndex [

	^ FTCellMorph new
		  addMorphBack:
			  ((self elementAt: rowIndex) kJpermol printShowingDecimalPlaces: 1)
				  asStringMorph;
		  listCentering: #center;
		  yourself
]

{ #category : #accessing }
RMapDistanceDataSource >> labelColumn: column row: rowIndex [

	^ FTCellMorph new
		  addMorphBack: (self elementAt: rowIndex) label asStringMorph;
		  listCentering: #center;
		  yourself
]

{ #category : #menus }
RMapDistanceDataSource >> menuColumn: column row: rowIndex [

	"Answer a menu for the (column, row) provided"

	^ rowIndex > 0
		  ifTrue: [ 
			  rmap
				  addVertexMenu: (UIManager default newMenuIn: self for: self)
				  on: (self elementAt: rowIndex) ]
		  ifFalse: [ nil ]
]

{ #category : #accessing }
RMapDistanceDataSource >> modelColumn: column row: rowIndex [

	^ FTCellMorph new
		  addMorphBack: (self elementAt: rowIndex) model64Form asMorph;
		  listCentering: #center;
		  yourself
]

{ #category : #'user interface' }
RMapDistanceDataSource >> openInWindowLabeled: aString [

	^ FTTableMorph new
		  extent: 400 @ 500;
		  addColumn: ((FTColumn id: 'label')
				   width: 70;
				   yourself);
		  addColumn: ((FTColumn id: 'model')
				   width: 72;
				   yourself);
		  addColumn: (FTColumn id: 'energy');
		  addColumn: (FTColumn id: 'distance');
		  rowHeight: 70;
		  dataSource: self;
		  beResizable;
		  openInWindowLabeled: aString;
		  yourself
]

{ #category : #accessing }
RMapDistanceDataSource >> rmap: aRMapMorph [

	rmap := aRMapMorph
]
