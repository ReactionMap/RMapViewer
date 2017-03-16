utilities
makeReleaseImage
	"RMapMorph makeReleaseImage"

	World submorphs copy do: [ :m | m delete ].
	isReleased := true.
	Smalltalk snapshot: true andQuit: false