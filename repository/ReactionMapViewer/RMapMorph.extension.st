Extension { #name : #RMapMorph }

{ #category : #'*ReactionMapViewer-GRRMImport' }
RMapMorph class >> fromDirectory: aFileReference [

	(aFileReference filesMatching: '*.com') ifNotEmpty: [
		^ self fromGRRMDirectory: aFileReference ].
	(aFileReference filesMatching: '*TS_list.xyz') ifNotEmpty: [
		^ self fromTrajectoryDirectory: aFileReference ].
	^ nil
]
