Class {
	#name : #RMapGRRMFullImporter,
	#superclass : #RMapGRRMImporter,
	#category : #'ReactionMapViewer-GRRMImport'
}

{ #category : #reading }
RMapGRRMFullImporter >> findPrefix [

	(ref filesMatching: '*_TS_list.log') do: [ :f |
		| p |
		p := f basename allButLast: '_TS_list.log' size.
		((ref / (p , '_EQ_list.log')) exists and: [
			 (ref / (p , '_DC_list.log')) exists and: [
				 (ref / (p , '_TS_list.log')) exists ] ]) ifTrue: [ ^ p ] ].
	^ nil
]

{ #category : #reading }
RMapGRRMFullImporter >> readDCs [

	^ super readDCs
		  do: [ :dc |
			  ref / (prefix , '_' , dc label , '.log') readStreamDo: [ :stream |
					  dc readMultiframe: stream ] ];
		  yourself
]

{ #category : #reading }
RMapGRRMFullImporter >> readTSs [

	^ super readTSs
		  do: [ :ts |
			  ref / (prefix , '_' , ts label , '.log') readStreamDo: [ :stream |
					  ts readMultiframe: stream ] ];
		  yourself
]
