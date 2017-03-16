enumerating
atomsDo: aBlock
	atoms do: [  :assoc | aBlock value: assoc key value: assoc value ]