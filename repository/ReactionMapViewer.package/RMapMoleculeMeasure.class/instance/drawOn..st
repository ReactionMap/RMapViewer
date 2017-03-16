drawing
drawOn: aCanvas
	| form rc measureString |
	form := Form extent: self innerBounds extent depth: 32.
	rc := [ form renderingContext ]
		on: Error
		do: [ :ex | nil ].
	rc
		ifNil: [ 
			rc := [ form renderingContext ]
				on: Error
				do: [ :ex | nil ] ].
	rc
		ifNil: [ 
			rc := [ form renderingContext ]
				on: Error
				do: [ :ex | nil ] ].
	rc ifNil: [ ^ self ].
	rc enableCullface.
	rc backgroundColor: self color.
	rc projection: projection.
	rc clear.
	rc ambientLight: Color gray.
	rc lightIndex: 0 parallel: projection eyePoint negated color: Color gray.
	presentation = #tube
		ifTrue: [ self renderTubeOn: rc ]
		ifFalse: [ 
			presentation = #vanDerWaals
				ifTrue: [ self renderVanDerWaalsOn: rc ]
				ifFalse: [ self renderStickAndBallOn: rc ] ].
	self isDistanceMode
		ifTrue: [ self renderDistanceMeasure: rc ].
	self isAngleMode
		ifTrue: [ self renderAngleMeasure: rc ].
	self isDihedralAngleMode
		ifTrue: [ self renderDihedralAngleMeasure: rc ].
	rc flush.
	aCanvas translucentImage: form at: self innerBounds origin.
	measureString := self measureString.
	aCanvas
		drawString: measureString
		at: self bounds topRight - (((font widthOfString: measureString) + 10) @ -10)
		font: font
		color: Color white.
	molecule label
		ifNotNil: [ :caption | 
			aCanvas
				drawString: caption
				at: self bounds bottomCenter - (((font widthOfString: caption) / 2.0) @ (font height * 1.2))
				font: font
				color:
					(self isWhiteBackground
						ifTrue: [ Color black ]
						ifFalse: [ Color white ]) ]