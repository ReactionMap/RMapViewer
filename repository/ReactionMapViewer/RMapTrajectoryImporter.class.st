Class {
	#name : #RMapTrajectoryImporter,
	#superclass : #RMapImporter,
	#category : #'ReactionMapViewer-GRRMImport'
}

{ #category : #reading }
RMapTrajectoryImporter >> findPrefix [

	(ref filesMatching: '*_TS_list.xyz') do: [ :f |
		| p |
		p := f basename allButLast: '_TS_list.xyz' size.
		((ref / (p , '_EQ_list.xyz')) exists and: [
			 (ref / (p , '_TS_list.xyz')) exists ]) ifTrue: [ ^ p ] ].
	^ nil
]

{ #category : #reading }
RMapTrajectoryImporter >> readBabel [

	
]

{ #category : #reading }
RMapTrajectoryImporter >> readDCs [

	^ Array new
]

{ #category : #reading }
RMapTrajectoryImporter >> readEQs [

	^ Array streamContents: [ :eqStream |
		  ref / (prefix , '_EQ_list.xyz') readStreamDo: [ :stream |
			  [ stream atEnd ] whileFalse: [
				  | eq numLines |
				  eq := RMapImportEQ new.
				  eq label: 'EQ' , eqStream position printString.
				  eqStream nextPut: eq.
				  numLines := stream nextLine.
				  (stream nextLine substrings: ',') do: [ :pairString |
					  | pair |
					  pair := pairString substrings: '='.
					  (pair size = 2 and: [ pair first trim first = $E ]) ifTrue: [
						  eq energy: pair second trim ] ].
				  numLines trim asInteger timesRepeat: [
					  eq geometryAdd: stream nextLine substrings ] ] ] ]
]

{ #category : #reading }
RMapTrajectoryImporter >> readTSs [

	^ ((Array streamContents: [ :tsStream |
		    ref / (prefix , '_TS_list.xyz') readStreamDo: [ :stream |
			    [ stream atEnd ] whileFalse: [
				    | ts numLines |
				    ts := RMapImportTS new.
				    ts label: 'TS' , tsStream position printString.
				    tsStream nextPut: ts.
				    numLines := stream nextLine.
				    (stream nextLine substrings: ',') do: [ :pairString |
					    | pair |
					    pair := pairString substrings: '='.
					    (pair size = 2 and: [ pair first trim = 'E' ]) ifTrue: [
						    ts energy: pair second trim ].
					    pair := pairString substrings: ':'.
					    (pair size = 2 and: [ pair first trim = 'CONNECTION' ])
						    ifTrue: [
							    | connections |
							    connections := pair second substrings: '-'.
							    connections size = 2 ifTrue: [
								    connections first trim asInteger ifNotNil: [ :index1 |
									    connections second trim asInteger ifNotNil: [ :index2 |
										    ts eq1: (eqs at: index1 + 1 ifAbsent: [ nil ]).
										    ts eq2: (eqs at: index2 + 1 ifAbsent: [ nil ]) ] ] ] ] ].
				    numLines trim asInteger timesRepeat: [
					    ts geometryAdd: stream nextLine substrings ] ] ] ]) select:
		   #isValid) do: [ :ts | ts createSoleMultiframe ]
]
