accessing-cursor
cursor2dPoint
	^ (ActiveHand position - self innerBounds center) * (2.0 @ -2.0) / self innerBounds height