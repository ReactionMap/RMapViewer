Class {
	#name : #RMapHopsFromReactants,
	#superclass : #RMapVertexNumerizer,
	#instVars : [
		'hops'
	],
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapHopsFromReactants >> hops [
	^ hops
		ifNil: [ 
			| dict maxHops tmpHops |
			dict := IdentityDictionary new.
			maxHops := 0.
			rmap hasMarkedVertices
				ifTrue: [ 
					| agenda |
					agenda := OrderedCollection new.
					rmap reactantsDo:
						 [ :vertex | 
							dict at: vertex put: 0.
							vertex
								edgesDo: [ :edge | 
									(rmap isEffectiveEdge: edge)
										ifTrue: [ agenda add: edge ] ] ].
					maxHops := maxHops + 1.
					[ agenda notEmpty ]
						whileTrue: [ 
							| nextAgenda |
							nextAgenda := OrderedCollection new.
							agenda
								do: [ :edge | 
									((dict includesKey: edge vertex1) not and: [ rmap isEffectiveVertex: edge vertex1 ])
										ifTrue: [ 
											dict at: edge vertex1 put: maxHops.
											edge vertex1 edgesDo: [ :e | nextAgenda add: e ] ].
									((dict includesKey: edge vertex2) not and: [ rmap isEffectiveVertex:  edge vertex2 ])
										ifTrue: [ 
											dict at: edge vertex2 put: maxHops.
											edge vertex2 edgesDo: [ :e | nextAgenda add: e ] ] ].
							maxHops := maxHops + 1.
							agenda := nextAgenda ].
					maxHops := maxHops - 1 ]
				ifFalse: [ 
					rmap
						verticesDo: [ :vertex | 
							dict
								at: vertex
								put:
									(vertex label first = $E
										ifTrue: [ 1 ]
										ifFalse: [ 
											vertex label first = $T
												ifTrue: [ 2 ]
												ifFalse: [ 0 ] ]) ].
					maxHops := 2 ].
			tmpHops := IdentityDictionary new.
			maxHops > 1
				ifTrue: [ dict keysAndValuesDo: [ :vertex :hop | tmpHops at: vertex put: hop asFloat / maxHops ] ]
				ifFalse: [ dict keysAndValuesDo: [ :vertex :hop | tmpHops at: vertex put: 0.5 ] ].
			hops := tmpHops ]
]

{ #category : #accessing }
RMapHopsFromReactants >> name [
	^ 'Hops'
]

{ #category : #accessing }
RMapHopsFromReactants >> reset [
	hops := nil
]

{ #category : #accessing }
RMapHopsFromReactants >> update [
	hops := nil
]

{ #category : #accessing }
RMapHopsFromReactants >> updateSelection [
	self transitionLinearTo: self copy reset
]

{ #category : #accessing }
RMapHopsFromReactants >> value: anRMapVertex [
	^ self hops at: anRMapVertex ifAbsent: [  ]
]
