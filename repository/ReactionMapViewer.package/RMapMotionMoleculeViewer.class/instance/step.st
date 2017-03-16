stepping and presenter
step
	isPlaying = true
		ifFalse: [ 
			self stopStepping.
			^ self ].
	moleculeIndex < motionMolecule size
		ifTrue: [ self moleculeIndex: moleculeIndex + 1 ]
		ifFalse: [ 
			self pause.
			self updateButtons ]