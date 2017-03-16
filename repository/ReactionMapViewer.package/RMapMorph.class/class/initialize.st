class initialization
initialize
	"RMapMorph initialize"

	| handler |
	(ExternalDropHandler registeredHandlers select: [ :h | h extension = 'rmap' ])
		do: [ :h | ExternalDropHandler registeredHandlers remove: h ifAbsent: [  ] ].
	handler := ExternalDropHandler
		type: nil
		extension: 'rmap'
		action: [ :dropStream | (RMapMorph fromStream: dropStream) openFullInWorld ].
	ExternalDropHandler registerHandler: handler.
	isReleased := false