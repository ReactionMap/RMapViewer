accessing
yAtEnergy: aNumber
	^ self bottom - (self height - 1 * (aNumber - self min) / (self max - self min)) asFloat