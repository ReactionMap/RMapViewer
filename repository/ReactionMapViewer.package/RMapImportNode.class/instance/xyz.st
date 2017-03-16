accessing
xyz
	^ geometry size printString , String lf , String lf
		,
			(String lf
				join:
					(geometry
						collect: [ :quad | 
							quad first , String tab , (quad second printShowingDecimalPlaces: 12) , String tab
								, (quad third printShowingDecimalPlaces: 12) , String tab , (quad fourth printShowingDecimalPlaces: 12) ]))
		, String lf