Class {
	#name : #RMapWatchItem,
	#superclass : #Object,
	#instVars : [
		'name',
		'directory',
		'interval',
		'paused',
		'type',
		'lastFetch',
		'nextFetch',
		'rmap',
		'fetchProcess'
	],
	#classVars : [
		'PauseIcon'
	],
	#category : #'ReactionMapViewer-Watcher'
}

{ #category : #icons }
RMapWatchItem class >> failureIcon [

	^ Smalltalk ui iconNamed: 'delete'
]

{ #category : #accessing }
RMapWatchItem class >> grrmDigest [

	^ 'GRRM (digest)'
]

{ #category : #accessing }
RMapWatchItem class >> grrmFull [

	^ 'GRRM (full)'
]

{ #category : #icons }
RMapWatchItem class >> pauseIcon [

	^ PauseIcon ifNil: [
		  | form |
		  form := Form extent: 16 @ 16 depth: 32.
		  form getCanvas
			  paintImage: (Smalltalk ui iconNamed: 'smallProfile') at: 0 @ 0;
			  fillRectangle: (9 @ 8 corner: 11 @ 15) color: Color black;
			  fillRectangle: (13 @ 8 corner: 15 @ 15) color: Color black;
			  flush.
		  PauseIcon := form ]
]

{ #category : #accessing }
RMapWatchItem class >> trajectory [

	^ 'Trajectory'
]

{ #category : #icons }
RMapWatchItem class >> updatingIcon [

	^ Smalltalk ui iconNamed: 'smallUpdate'
]

{ #category : #icons }
RMapWatchItem class >> waitingIcon [

	^ Smalltalk ui iconNamed: 'smallProfile'
]

{ #category : #defaults }
RMapWatchItem >> defaultDirectory [

	^ nil
]

{ #category : #defaults }
RMapWatchItem >> defaultInterval [

	^ 1 hour
]

{ #category : #defaults }
RMapWatchItem >> defaultName [

	^ ''
]

{ #category : #defaults }
RMapWatchItem >> defaultType [

	^ self class trajectory
]

{ #category : #operations }
RMapWatchItem >> delete [

	fetchProcess ifNotNil: [ :p |
		fetchProcess := nil.
		p terminate ].
	rmap := nil
]

{ #category : #accessing }
RMapWatchItem >> directory [

	^ directory
]

{ #category : #accessing }
RMapWatchItem >> directory: aFileReference [

	directory := aFileReference
]

{ #category : #operations }
RMapWatchItem >> fetch [

	fetchProcess ifNotNil: [ ^ nil ].
	fetchProcess := [
	                (self importer ifNotNil: #rmap) ifNotNil: [ :newRmap |
		                rmap := newRmap ].
	                lastFetch := DateAndTime now.
	                nextFetch := lastFetch + interval.
	                fetchProcess := nil ] forkAt:
		                Processor userBackgroundPriority
]

{ #category : #accessing }
RMapWatchItem >> icon [

	fetchProcess ifNotNil: [ ^ self class updatingIcon ].
	paused = true ifTrue: [ ^ self class pauseIcon ].
	(lastFetch notNil and: [ rmap isNil ]) ifTrue: [
		^ self class failureIcon ].
	^ self class waitingIcon
]

{ #category : #accessing }
RMapWatchItem >> importer [

	^ directory ifNotNil: [ RMapGRRMDigestImporter on: directory ]
]

{ #category : #initialization }
RMapWatchItem >> initialize [

	super initialize.
	name := self defaultName.
	directory := self defaultDirectory.
	interval := self defaultInterval.
	type := self defaultType.
	paused := false
]

{ #category : #accessing }
RMapWatchItem >> interval [

	^ interval
]

{ #category : #accessing }
RMapWatchItem >> interval: aDuration [

	interval := aDuration
]

{ #category : #accessing }
RMapWatchItem >> lastFetchString [

	^ lastFetch ifNotNil: [ lastFetch asTime print24 ] ifNil: [ '-' ]
]

{ #category : #accessing }
RMapWatchItem >> name [

	^ name
]

{ #category : #accessing }
RMapWatchItem >> name: aString [

	name := aString
]

{ #category : #accessing }
RMapWatchItem >> nextFetchString [

	^ nextFetch ifNotNil: [ nextFetch asTime print24 ] ifNil: [ '-' ]
]

{ #category : #accessing }
RMapWatchItem >> numEQs [

	^ rmap
		  ifNotNil: [
		  (rmap vertices count: [ :v | v label first = $E ]) printString ]
		  ifNil: [ '' ]
]

{ #category : #accessing }
RMapWatchItem >> numTSs [

	^ rmap
		  ifNotNil: [
		  (rmap vertices count: [ :v | v label first = $T ]) printString ]
		  ifNil: [ '' ]
]

{ #category : #operations }
RMapWatchItem >> pause [

	paused := paused = false
]

{ #category : #accessing }
RMapWatchItem >> rmap [

	^ rmap
]

{ #category : #accessing }
RMapWatchItem >> type [

	^ type
]

{ #category : #accessing }
RMapWatchItem >> type: aString [

	type := aString
]

{ #category : #operations }
RMapWatchItem >> watch [

	| now |
	now := DateAndTime now.
	(fetchProcess isNil and: [
		 nextFetch isNil or: [ nextFetch <= now and: [ paused ~= true ] ] ])
		ifTrue: [ ^ self fetch ].
	^ nil
]
