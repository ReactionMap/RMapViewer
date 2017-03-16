private
searcher
	pathSorter = #energy ifTrue: [ ^ RMapEnergyShortestPathSearcher on: self ].
	pathSorter = #deltaEnergy ifTrue: [ ^ RMapEnergyGapShortestPathSearcher on: self ].
	pathSorter = #hops ifTrue: [ ^ RMapSimpleShortestPathSearcher on: self ].
	self error: 'unknown sorter'