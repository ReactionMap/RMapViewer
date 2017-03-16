drawing
drawPathsOn: aCanvas color: aColor
	| paths selectedPath hopCount shadowColor maxHopCount |
	paths := rmapMorph paths.
	selectedPath := rmapMorph selectedPath ifNil: [ Array new ].
	hopCount := 0.
	maxHopCount := paths inject: 0 into: [ :sum :path | sum max: path size ].
	shadowColor := aColor mixed: 0.2 with: Color white.
	[ hopCount <= maxHopCount ]
		whileTrue: [ 
			| vertices pairs |
			vertices := Set new: 1024.
			pairs := Set new: 1024.
			paths
				do: [ :path | 
					(path at: hopCount + 1 ifAbsent: [  ])
						ifNotNil: [ :vertex | 
							vertices add: vertex.
							(path at: hopCount + 2 ifAbsent: [  ]) ifNotNil: [ :vertex2 | pairs add: (Array with: vertex with: vertex2) ] ] ].
			vertices
				do: [ :vertex | 
					vertex ~= (selectedPath at: hopCount + 1 ifAbsent: [  ])
						ifTrue: [ 
							self
								drawVertex: vertex
								hop: hopCount
								color: shadowColor
								on: aCanvas ] ].
			pairs
				do: [ :pair | 
					(pair first = (selectedPath at: hopCount + 1 ifAbsent: [  ])
						and: [ pair second = (selectedPath at: hopCount + 2 ifAbsent: [  ]) ])
						ifFalse: [ 
							self
								drawEdgeFrom: pair first
								to: pair second
								hop: hopCount
								color: shadowColor
								on: aCanvas ] ].
			(selectedPath at: hopCount + 1 ifAbsent: [  ])
				ifNotNil: [ :vertex | 
					self
						drawVertex: vertex
						hop: hopCount
						color: aColor
						on: aCanvas.
					(selectedPath at: hopCount + 2 ifAbsent: [  ])
						ifNotNil: [ :vertex2 | 
							self
								drawEdgeFrom: vertex
								to: vertex2
								hop: hopCount
								color: aColor
								on: aCanvas ] ].
			hopCount := hopCount + 1 ]