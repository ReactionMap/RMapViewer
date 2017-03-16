accessing
denominator
	^ denominator ifNil: [ denominator := self max - self min ]