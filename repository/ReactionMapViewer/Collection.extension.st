Extension { #name : #Collection }

{ #category : #'*ReactionMapViewer' }
Collection >> argmax: aBlock [
	| argmax max |
	argmax := nil.
	max := Float fmin.
	self
		do: [ :elem | 
			| value |
			value := aBlock value: elem.
			value > max
				ifTrue: [ 
					max := value.
					argmax := elem ] ].
	^ argmax
]

{ #category : #'*ReactionMapViewer' }
Collection >> argmin: aBlock [
	| argmin min |
	argmin := nil.
	min := Float fmax.
	self
		do: [ :elem | 
			| value |
			value := aBlock value: elem.
			value < min
				ifTrue: [ 
					min := value.
					argmin := elem ] ].
	^ argmin
]

{ #category : #'*ReactionMapViewer' }
Collection >> sum0 [
	^ self inject: 0.0 into: [ :sum :each | sum + each ]
]
