initialize-release
initialize
	super initialize.
	atoms := Array new: 4.
	measureMode := #distance.
	dragSource := nil.
	dropTarget := nil