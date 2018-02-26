initialize-release
initialize
	super initialize.
	self stickAndBallPresentation.
	self color: self defaultColor.
	font := FreeTypeFontProvider current
		fontFor:
			(LogicalFont
				familyName: 'Arial'
				pointSize: 24
				stretchValue: 5
				weightValue: LogicalFont weightBold
				slantValue: 0)
		familyName: 'Arial'.
	font
		ifNil: [ 
			FreeTypeFontProvider current updateFromSystem.
			font := FreeTypeFontProvider current
				fontFor:
					(LogicalFont
						familyName: 'Arial'
						pointSize: 24
						stretchValue: 5
						weightValue: LogicalFont weightBold
						slantValue: 0)
				familyName: 'Arial' ].
	font ifNil: [ font := TextStyle default defaultFont ]