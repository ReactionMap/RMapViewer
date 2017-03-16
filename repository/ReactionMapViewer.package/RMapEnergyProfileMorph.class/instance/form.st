accessing
form
	^ form ifNil: [ form := self createForm ]