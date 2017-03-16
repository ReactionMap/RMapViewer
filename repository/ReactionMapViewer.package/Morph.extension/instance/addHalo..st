*ReactionMapViewer
addHalo: evt
	| halo prospectiveHaloClass |
	Smalltalk tools userManager canShowMorphHalo
		ifFalse: [ ^ self ].
	((Smalltalk includesKey: #RMapMorph) and: [ (Smalltalk at: #RMapMorph) isReleaseImage ])
		ifTrue: [ ^ self ].
	prospectiveHaloClass := Smalltalk globals at: self haloClass ifAbsent: [ HaloMorph ].
	halo := prospectiveHaloClass new.
	halo bounds: (halo worldBoundsForMorph: self).
	halo popUpFor: self event: evt.
	^ halo