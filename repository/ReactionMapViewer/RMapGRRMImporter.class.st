Class {
	#name : #RMapGRRMImporter,
	#superclass : #RMapImporter,
	#category : #'ReactionMapViewer-GRRMImport'
}

{ #category : #testing }
RMapGRRMImporter class >> isAbstract [

	^ self = RMapGRRMImporter
]

{ #category : #reading }
RMapGRRMImporter >> findPrefix [

	(ref filesMatching: '*_TS_list.log') do: [ :f |
		| p |
		p := f basename allButLast: '_TS_list.log' size.
		((ref / (p , '_EQ_list.log')) exists and: [
			 (ref / (p , '_TS_list.log')) exists ]) ifTrue: [ ^ p ] ].
	^ nil
]

{ #category : #reading }
RMapGRRMImporter >> readDCs [

	^ Array streamContents: [ :dcStream |
		  ref / (prefix , '_DC_list.log') readStreamDo: [ :logStream |
			  | dc geometryMode |
			  dc := nil.
			  geometryMode := false.
			  logStream contents linesDo: [ :line |
				  ('# Geometry of *' match: line)
					  ifTrue: [
						  geometryMode := true.
						  dc := RMapImportDC new.
						  dc label: 'DC' , dcStream position printString.
						  dcStream nextPut: dc ]
					  ifFalse: [
						  ('Energy*' match: line)
							  ifTrue: [
								  dc energy:
									  (line substrings: '=') second trim asNumber asFloat.
								  geometryMode := false ]
							  ifFalse: [
								  ('CONNECTION*' match: line)
									  ifTrue: [
										  | start end |
										  start := (line indexOf: $:) + 1.
										  end := (line indexOf: $-) - 1.
										  dc eq:
											  (eqs at:
												   (line copyFrom: start to: end) trim asNumber asInteger
												   + 1).
										  dc := nil ]
									  ifFalse: [
										  geometryMode ifTrue: [
											  | items |
											  items := line substrings.
											  dc geometryAdd: items ] ] ] ] ] ] ]
]

{ #category : #reading }
RMapGRRMImporter >> readEQs [

	^ Array streamContents: [ :eqStream |
		  ref / (prefix , '_EQ_list.log') readStreamDo: [ :logStream |
			  | eq |
			  eq := nil.
			  logStream contents linesDo: [ :line |
				  ('# Geometry of *' match: line)
					  ifTrue: [
						  eq := RMapImportEQ new.
						  eq label: 'EQ' , eqStream position printString ]
					  ifFalse: [
						  ('Energy*' match: line)
							  ifTrue: [
								  eq energy: (line substrings: '=') second trim.
								  eqStream nextPut: eq.
								  eq := nil ]
							  ifFalse: [
								  eq ifNotNil: [
									  | items |
									  items := line substrings.
									  eq geometryAdd: items ] ] ] ] ] ]
]

{ #category : #reading }
RMapGRRMImporter >> readTSs [

	^ Array streamContents: [ :tsStream |
		  ref / (prefix , '_TS_list.log') readStreamDo: [ :logStream |
			  | id ts geometryMode |
			  id := 0.
			  ts := nil.
			  geometryMode := false.
			  logStream contents linesDo: [ :line |
				  ('# Geometry of *' match: line)
					  ifTrue: [
						  geometryMode := true.
						  ts := RMapImportTS new.
						  ts label: 'TS' , id printString.
						  id := id + 1.
						  tsStream nextPut: ts ]
					  ifFalse: [
						  ('Energy*' match: line)
							  ifTrue: [
								  ts energy:
									  (line substrings: '=') second trim asNumber asFloat.
								  geometryMode := false ]
							  ifFalse: [
								  ('CONNECTION*' match: line)
									  ifTrue: [
										  | start end eq1 eq2 |
										  start := (line indexOf: $:) + 1.
										  end := (line indexOf: $-) - 1.
										  ([
										   eq1 := (line copyFrom: start to: end) trim asNumber
											          asInteger + 1.
										   eq2 := (line copyFrom: end + 2 to: line size) trim
											          asNumber asInteger + 1.
										   true ]
											   on: Error
											   do: [ :ex | false ])
											  ifTrue: [
												  ts eq1: (eqs at: eq1).
												  ts eq2: (eqs at: eq2) ]
											  ifFalse: [ tsStream position: tsStream position - 1 ].
										  ts := nil ]
									  ifFalse: [
										  geometryMode ifTrue: [
											  | items |
											  items := line substrings.
											  ts geometryAdd: items ] ] ] ] ] ] ]
]
