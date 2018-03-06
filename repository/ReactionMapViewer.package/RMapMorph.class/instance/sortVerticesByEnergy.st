private
sortVerticesByEnergy
	| baselineEnergy |
	vertices := vertices asSortedCollection: [  :less :more | less energy >= more energy ].
	baselineEnergy := vertices last energy.
	vertices do: [ :v | v baselineEnergy: baselineEnergy  ]