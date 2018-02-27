utilities
makeReleaseImage
	"RMapMorph makeReleaseImage"

	World submorphs copy do: [ :m | m delete ].
	isReleased := true.
	RMapMorph new openFullInWorld.
	Smalltalk snapshot: true andQuit: false