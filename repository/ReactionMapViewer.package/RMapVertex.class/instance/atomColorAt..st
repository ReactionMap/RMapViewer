accessing
atomColorAt: anAtomName
	^AtomColors at: anAtomName ifAbsent: [ Color black ]