utilities
makeReleaseImage
	"RMapMorph makeReleaseImage"

	World submorphs copy do: [ :m | m delete ].
	RMapMorph new openFullInWorld.
	isReleased := true.
	Smalltalk snapshot: true andQuit: false