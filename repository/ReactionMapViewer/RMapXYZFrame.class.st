Class {
	#name : #RMapXYZFrame,
	#superclass : #Object,
	#instVars : [
		'atoms'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'instance creation' }
RMapXYZFrame class >> from: aCollectionOfAssociationsFromStringToRMap3dPoint [
	^ self new
		setAtoms: aCollectionOfAssociationsFromStringToRMap3dPoint;
		yourself
]

{ #category : #'instance creation' }
RMapXYZFrame class >> fromGeometry: anArrayOfQuadruple [
	^ self
		from:
			(anArrayOfQuadruple collect: [ :quad | quad first -> (RMap3dPoint x: quad second y: quad third z: quad fourth) ])
]

{ #category : #'instance creation' }
RMapXYZFrame class >> fromXYZ: aString [ 
	^ self fromXYZStream: aString readStream
]

{ #category : #'instance creation' }
RMapXYZFrame class >> fromXYZ: aString transformationBlock: aBlock [
	^ self fromXYZStream: aString readStream transformationBlock: aBlock
]

{ #category : #'instance creation' }
RMapXYZFrame class >> fromXYZStream: aStream [
	^ Array new writeStream
		in: [ :atoms | 
			| size |
			size := aStream nextLine asInteger.
			aStream nextLine.
			size
				timesRepeat: [ 
					aStream nextLine substrings
						in: [ :quad | atoms nextPut: quad first -> (RMap3dPoint x: quad second asNumber y: quad third asNumber z: quad fourth asNumber) ] ].
			self from: atoms contents ]
]

{ #category : #'instance creation' }
RMapXYZFrame class >> fromXYZStream: aStream transformationBlock: aBlock [
	^ Array new writeStream
		in: [ :atoms | 
			| size |
			size := aStream nextLine asInteger.
			aStream nextLine.
			size
				timesRepeat: [ 
					aStream nextLine substrings
						in: [ :quad | 
							atoms
								nextPut:
									quad first -> (aBlock value: (RMap3dPoint x: quad second asNumber y: quad third asNumber z: quad fourth asNumber)) ] ].
			self from: atoms contents ]
]

{ #category : #accessing }
RMapXYZFrame >> atomAt: anInteger [
	^(atoms at: anInteger) key
]

{ #category : #transformation }
RMapXYZFrame >> atomMapWith: anRMapXYZFrame [
	| stderr myIndex1 myIndex2 myIndex3 myAtom1 myAtom2 myAtom3 myPoint1 myPoint2 myPoint3 mySqDist12 mySqDist23 mySqDist31 bestMap bestSSE |
	stderr := 1.0.
	atoms size = 1
		ifTrue: [ ^ Array with: 1 ].
	atoms size = 2
		ifTrue: [ 
			^ (self atomAt: 1) = (anRMapXYZFrame atomAt: 1)
				ifTrue: [ Array with: 1 with: 2 ]
				ifFalse: [ Array with: 2 with: 1 ] ].
	myIndex1 := 1.
	myIndex2 := 2.
	myIndex3 := 3.
	myAtom1 := self atomAt: myIndex1.
	myAtom2 := self atomAt: myIndex2.
	myAtom3 := self atomAt: myIndex3.
	myPoint1 := self pointAt: myIndex1.
	myPoint2 := self pointAt: myIndex2.
	myPoint3 := self pointAt: myIndex3.
	mySqDist12 := myPoint1 squaredDist: myPoint2.
	mySqDist23 := myPoint2 squaredDist: myPoint3.
	mySqDist31 := myPoint3 squaredDist: myPoint1.
	bestMap := Array with: 1 with: 2 with: 3.
	bestSSE := Float fmax.
	1 to: atoms size do: [ :hisIndex1 | 
		| hisAtom1 |
		hisAtom1 := anRMapXYZFrame atomAt: hisIndex1.
		myAtom1 = hisAtom1
			ifTrue: [ 
				| hisPoint1 possibleIndices3 |
				hisPoint1 := anRMapXYZFrame pointAt: hisIndex1.
				possibleIndices3 := (1 to: atoms size)
					select: [ :index | ((hisPoint1 squaredDist: (anRMapXYZFrame pointAt: index)) - mySqDist31) abs < stderr ].
				1 to: atoms size do: [ :hisIndex2 | 
					| hisAtom2 hisPoint2 |
					hisAtom2 := anRMapXYZFrame atomAt: hisIndex2.
					hisPoint2 := anRMapXYZFrame pointAt: hisIndex2.
					(myAtom2 = hisAtom2
						and: [ hisIndex1 ~= hisIndex2 and: [ ((hisPoint1 squaredDist: hisPoint2) - mySqDist12) abs < stderr ] ])
						ifTrue: [ 
							possibleIndices3
								do: [ :hisIndex3 | 
									| hisAtom3 hisPoint3 |
									hisAtom3 := anRMapXYZFrame atomAt: hisIndex3.
									hisPoint3 := anRMapXYZFrame pointAt: hisIndex3.
									(myAtom3 = hisAtom3
										and: [ 
											hisIndex1 ~= hisIndex3
												and: [ hisIndex2 ~= hisIndex3 and: [ ((hisPoint2 squaredDist: hisPoint3) - mySqDist23) abs < stderr ] ] ])
										ifTrue: [ 
											| map transform sse |
											map := Array with: hisIndex1 with: hisIndex2 with: hisIndex3.
											transform := self transformationBlockWith: anRMapXYZFrame atomMap: map.
											sse := 0.0.
											1 to: atoms size do: [ :i | 
												sse := sse
													+
														((self pointAt: i)
															squaredDist:
																(transform
																	value:
																		(anRMapXYZFrame
																			pointAt:
																				(map
																					at: i
																					ifAbsent: [ 
																						| bestIndex minDist |
																						bestIndex := 1.
																						minDist := Float fmax.
																						1 to: atoms size do: [ :j | 
																							| dist |
																							dist := (self pointAt: i) squaredDist: (transform value: (anRMapXYZFrame pointAt: j)).
																							dist < minDist
																								ifTrue: [ 
																									bestIndex := j.
																									minDist := dist ] ].
																						bestIndex ])))) ].
											sse < bestSSE
												ifTrue: [ 
													bestSSE := sse.
													bestMap := map ] ] ] ] ] ] ].
	^ bestMap
]

{ #category : #enumerating }
RMapXYZFrame >> atomsDo: aBlock [
	atoms do: [  :assoc | aBlock value: assoc key value: assoc value ]
]

{ #category : #functions }
RMapXYZFrame >> centerOfGravity [
	| g |
	g := RMap3dPoint x: 0.0 y: 0.0 z: 0.0.
	self atomsDo: [ :atom :point |
		 g := g + point].
	^ g / atoms size
]

{ #category : #comparing }
RMapXYZFrame >> hash [
	^ atoms hash
]

{ #category : #accessing }
RMapXYZFrame >> pointAt: anInteger [
	^ (atoms at: anInteger) value
]

{ #category : #converting }
RMapXYZFrame >> printXYZOn: aStream [
	atoms size printOn: aStream.
	aStream cr.
	aStream cr.
	self
		atomsDo: [ :atom :point | 
			aStream nextPutAll: atom.
			aStream tab.
			point x printOn: aStream.
			aStream tab.
			point y printOn: aStream.
			aStream tab.
			point z printOn: aStream.
			aStream cr ]
]

{ #category : #private }
RMapXYZFrame >> setAtoms: aCollectionOfAssociationsFromStringToRMap3dPoint [ 
	atoms := aCollectionOfAssociationsFromStringToRMap3dPoint 
]

{ #category : #accessing }
RMapXYZFrame >> size [
	^ atoms size
]

{ #category : #transformation }
RMapXYZFrame >> transform: anRMapXYZFrame [
	| block |
	block := self transformationBlockWith: anRMapXYZFrame.
	^ Array new writeStream
		in: [ :transformedAtoms | 
			anRMapXYZFrame atomsDo: [ :atom :point | transformedAtoms nextPut: atom -> (block value: point) ].
			self class from: transformedAtoms contents ]
]

{ #category : #transformation }
RMapXYZFrame >> transformationBlockWith: anRMapXYZFrame [
	atoms size <= 1
		ifTrue: [ ^ [ :p | p ] ].
	^ self transformationBlockWith: anRMapXYZFrame atomMap: (self atomMapWith: anRMapXYZFrame)
]

{ #category : #transformation }
RMapXYZFrame >> transformationBlockWith: anRMapXYZFrame atomMap: map [
	| g1 g2 xAxis1 yAxis1 zAxis1 xAxis2 yAxis2 yAxis2l zAxis2l yAxis2r zAxis2r leftBlock rightBlock leftError rightError |
	atoms size <= 1
		ifTrue: [ ^ [ :p | p ] ].
	atoms size = 2
		ifTrue: [
			g1 := self centerOfGravity.
			g2 := anRMapXYZFrame centerOfGravity.
			xAxis1 := ((self pointAt: 2) - (self pointAt: 1)) unit.
			xAxis2 := ((anRMapXYZFrame pointAt: (map at: 2)) - (anRMapXYZFrame pointAt: (map at: 1))) unit.
			^ [ :p | 
			| point x y z |
			point := p - g2.
			x := xAxis2 dot: point.
			xAxis1 * x + g1 ] ].
	g1 := self centerOfGravity.
	g2 := anRMapXYZFrame centerOfGravity.
	xAxis1 := ((self pointAt: 2) - (self pointAt: 1)) unit.
	yAxis1 := ((self pointAt: 3) - (self pointAt: 1)) unit.
	zAxis1 := (xAxis1 cross: yAxis1) unit.
	yAxis1 := (zAxis1 cross: xAxis1) unit.
	xAxis2 := ((anRMapXYZFrame pointAt: (map at: 2)) - (anRMapXYZFrame pointAt: (map at: 1))) unit.
	yAxis2 := ((anRMapXYZFrame pointAt: (map at: 3)) - (anRMapXYZFrame pointAt: (map at: 1))) unit.
	zAxis2l := (xAxis2 cross: yAxis2) unit.
	yAxis2l := (zAxis2l cross: xAxis2) unit.
	zAxis2r := (yAxis2 cross: xAxis2) unit.
	yAxis2r := (xAxis2 cross: zAxis2r) unit.
	leftBlock := [ :p | 
	| point x y z |
	point := p - g2.
	x := xAxis2 dot: point.
	y := yAxis2l dot: point.
	z := zAxis2l dot: point.
	xAxis1 * x + (yAxis1 * y) + (zAxis1 * z) + g1 ].
	rightBlock := [ :p | 
	| point x y z |
	point := p - g2.
	x := xAxis2 dot: point.
	y := yAxis2r dot: point.
	z := zAxis2r dot: point.
	xAxis1 * x + (yAxis1 * y) + (zAxis1 * z) + g1 ].
	leftError := 0.0.
	rightError := 0.0.
	1 to: map size do: [ :index | 
		leftError := leftError
			+ ((self pointAt: index) squaredDist: (leftBlock value: (anRMapXYZFrame pointAt: (map at: index)))).
		rightError := rightError
			+ ((self pointAt: index) squaredDist: (rightBlock value: (anRMapXYZFrame pointAt: (map at: index)))) ].
	^ (leftError <= 1.0e-5 or: [rightError >= 1.0e-5])
		ifTrue: [ leftBlock ]
		ifFalse: [rightBlock ]
]
