transformation
transformationBlockWith: anRMapXYZFrame
	atoms size <= 1
		ifTrue: [ ^ [ :p | p ] ].
	^ self transformationBlockWith: anRMapXYZFrame atomMap: (self atomMapWith: anRMapXYZFrame)