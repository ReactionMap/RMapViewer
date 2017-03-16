private
sortVerticesByEnergy
	vertices := vertices asSortedCollection: [  :less :more | less energy >= more energy ]