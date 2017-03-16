dependents access
removeDependent: anObject
	dependents := dependents copyWithout: anObject.
	^ anObject