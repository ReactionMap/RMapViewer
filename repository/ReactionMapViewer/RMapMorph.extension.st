Extension { #name : #RMapMorph }

{ #category : #'*ReactionMapViewer-GRRMImport' }
RMapMorph class >> fromDirectory: aFileReference [

	(aFileReference filesMatching: '*TS_list.log') ifNotEmpty: [
		(self fromGRRMDirectory: aFileReference) ifNotNil: [ :rmap | ^ rmap ] ].
	(aFileReference filesMatching: '*TS_list.xyz') ifNotEmpty: [
		(self fromTrajectoryDirectory: aFileReference) ifNotNil: [ :rmap |
			^ rmap ] ].
	^ nil
]
