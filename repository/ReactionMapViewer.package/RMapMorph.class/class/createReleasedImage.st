class initialization
createReleasedImage
	"RMapMorph createReleasedImage"
	World submorphs copy do: [  :m | m delete ].
	isReleased := true.
	Smalltalk snapshot: true andQuit: true 