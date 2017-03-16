user interface
openInWindowLabeled: aString
	| window | 
	window := super openInWindowLabeled: aString.
	self color: self defaultColor.
	label := aString.
	^ window