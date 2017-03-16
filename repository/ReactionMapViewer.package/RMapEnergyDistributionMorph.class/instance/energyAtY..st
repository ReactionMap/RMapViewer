accessing
energyAtY: aNumber
	^ (self bottom - aNumber) asFloat * (self max - self min) / (self height - 1) + self min