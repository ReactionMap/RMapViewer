utilities
openOn: anRMapMorph
	| window |
	window := SystemWindow new.
	(self on: anRMapMorph) buildOn: window.
	window openInWorld.
	^ window