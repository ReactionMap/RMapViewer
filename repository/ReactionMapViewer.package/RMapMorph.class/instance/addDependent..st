dependents access
addDependent: anObject
	dependents := dependents copyWith: anObject.
	^ anObject