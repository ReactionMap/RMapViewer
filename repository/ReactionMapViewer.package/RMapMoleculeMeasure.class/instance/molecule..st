accessing
molecule: aJunMoleculeGeometry
	1 to: (aJunMoleculeGeometry size min: atoms size) do: [ :index | atoms at: index put: (aJunMoleculeGeometry at: index) ].
	^ super molecule: aJunMoleculeGeometry