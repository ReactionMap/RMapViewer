private
setJson: aDictionary
	json := aDictionary.
	(aDictionary at: 'position' ifAbsent: [Array with: 0 with: 0]) in:  [ :positionArray | position := positionArray first @ positionArray second ].
	(aDictionary at: 'bonds' ifAbsent: [Array new]) in: [ :bondsArray | bonds := bondsArray collect: [  :triple | Array with: triple first + 1 with: triple second + 1 with: triple third ] ].
	(aDictionary at: 'energy' ifAbsent: [0.0]) in: [:e | energy := e]