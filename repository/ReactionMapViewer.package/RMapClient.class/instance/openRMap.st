operations
openRMap
	| rmap |
	rmap := self getRMap: rmapList selectedItem.
	rmapMorph
		ifNil: [ 
			rmapMorph := RMapMorph fromDictionary: rmap.
			rmapMorph openInWindow ].
	rmapMorph load: rmap