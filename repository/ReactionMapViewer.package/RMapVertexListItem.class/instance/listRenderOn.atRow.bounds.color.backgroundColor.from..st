list icon support
listRenderOn: aCanvas atRow: row bounds: aRectangle color: aColor backgroundColor: backgroundColor from: aListMorph
	"aCanvas fillRectangle: aRectangle color: backgroundColor."
	"aCanvas paintImage: self form at: aRectangle topLeft"
	aCanvas drawString: vertex label at: 2 @ ((64 - TextStyle defaultFont height) / 2.0) + aRectangle topLeft.
	aCanvas paintImage: (vertex asFormExtent: self listIconSize @ self listIconSize) at: aRectangle topLeft + (70@0).