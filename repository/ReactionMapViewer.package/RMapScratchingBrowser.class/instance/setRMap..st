private
setRMap: anRMapMorph
	rmap := anRMapMorph.
	moleculeList := Array withAll: (anRMapMorph vertices asSortedCollection: [ :v1 :v2 | v1 energy <= v2 energy ])