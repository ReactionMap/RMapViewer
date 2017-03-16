transformation
atomMapWith: anRMapXYZFrame
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