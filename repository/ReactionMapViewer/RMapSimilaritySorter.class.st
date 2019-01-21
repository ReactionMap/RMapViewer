Class {
	#name : #RMapSimilaritySorter,
	#superclass : #Object,
	#instVars : [
		'rmap',
		'vertices',
		'signatures',
		'columnSize'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'instance creation' }
RMapSimilaritySorter class >> on: anRMapMorph [
	^ self new
		setRMap: anRMapMorph;
		yourself
]

{ #category : #accessing }
RMapSimilaritySorter >> columnSize [
	^ columnSize ifNil: [ columnSize := rmap vertices size sqrt ceiling ]
]

{ #category : #private }
RMapSimilaritySorter >> errorBetween: signature1 and: signature2 [
	| error |
	error := 0.0.
	signature1
		keysAndValuesDo: [ :atoms :distances1 | 
			signature2
				at: atoms
				ifPresent: [ :distances2 | 
					1 to: (distances1 size min: distances2 size) do: [ :i | 
						| d1 d2 |
						d1 := distances1 at: i.
						d2 := distances2 at: i.
						error := (d1 - d2) abs / (d1 max: d2) + error ].
					error := (distances1 size - distances2 size) abs + error ]
				ifAbsent: [ error := distances1 size + error ] ].
	signature2
		keysAndValuesDo: [ :atoms :distances2 | signature1 at: atoms ifAbsent: [ error := distances2 size + error ] ].
	^ error
]

{ #category : #accessing }
RMapSimilaritySorter >> indexOf: anRMapVertex [
	^ self vertices indexOf: anRMapVertex
]

{ #category : #private }
RMapSimilaritySorter >> setRMap: anRMapMorph [
	rmap := anRMapMorph
]

{ #category : #private }
RMapSimilaritySorter >> signatures [
	^ signatures
		ifNil: [ 
			| sigs |
			sigs := IdentityDictionary new.
			rmap vertices do: [ :v | sigs at: v put: v fullShapeSignature ].
			signatures := sigs ]
]

{ #category : #updating }
RMapSimilaritySorter >> update [
	
]

{ #category : #updating }
RMapSimilaritySorter >> updateSelection [
	"vertices := nil"
]

{ #category : #private }
RMapSimilaritySorter >> vertices [
	^ vertices
		ifNil: [ | selection |
			selection := rmap hoverVertex
				ifNotNil: [ :v | Array with: v ]
				ifNil: [ (rmap argminVertex: [ :vertex | vertex energy ])
						ifNotNil: [ :v | Array with: v ]
						ifNil: [ Array new ] ].
			vertices := selection
				ifEmpty: [ Array
						new: rmap vertices size
						streamContents: [ :stream | stream nextPutAll: rmap vertices ] ]
				ifNotEmpty: [ | keySignatures errors |
					keySignatures := selection
						collect: [ :v | self signatures at: v ifAbsent: [ Dictionary new ] ].
					errors := Array
						new: rmap vertices size
						streamContents: [ :stream | 
							self signatures
								keysAndValuesDo: [ :v :sig | 
									stream
										nextPut:
											(keySignatures
												collect: [ :keySig | self errorBetween: sig and: keySig ])
												min -> v ] ].
					(errors asSortedCollection collect: #value) asArray ] ]
]

{ #category : #accessing }
RMapSimilaritySorter >> xFor: anRMapVertex [
	| index |
	index := (self indexOf: anRMapVertex) - 1.
	index < 0
		ifTrue: [ ^ nil ].
	^ (index \\ self columnSize) asFloat / self columnSize asFloat
]

{ #category : #accessing }
RMapSimilaritySorter >> xNumerizer: aSymbol [
	^ RMapSimilarityX on: rmap setter: aSymbol sorter: self
]

{ #category : #accessing }
RMapSimilaritySorter >> yFor: anRMapVertex [
	| index |
	index := (self indexOf: anRMapVertex).
	index <= 0
		ifTrue: [ ^ nil ].
	^  ((self columnSize squared - index // self columnSize) asFloat / self columnSize asFloat)
]

{ #category : #accessing }
RMapSimilaritySorter >> yNumerizer: aSymbol [
	^ RMapSimilarityY on: rmap setter: aSymbol sorter: self
]
