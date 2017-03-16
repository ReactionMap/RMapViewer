private
xyzAnimationAndLabelDictionaryAndEnergyCurveFromPath
	| path labels energies frames |
	path := paths at: pathSelector index ifAbsent: [ ^ nil ].
	path isEmpty
		ifTrue: [ ^ nil ].
	labels := Dictionary new.
	frames := Array new writeStream.
	energies := Array new writeStream.
	path size = 1
		ifTrue: [ 
			frames nextPut: (RMapXYZFrame fromGeometry: path first geometry).
			energies nextPut: path first energies.
			labels at: 1 put: path first label ]
		ifFalse: [ 
			| frame |
			path first
				to: path second
				framesDo: [ :f | 
					frame := f.
					frames nextPut: f ].
			path first to: path second energiesDo: [ :e | energies nextPut: e ].
			labels at: 1 put: path first label.
			2 to: path size - 1 do: [ :index | 
				| v from to |
				v := path at: index.
				from := path at: index - 1.
				to := path at: index + 1.
				labels at: frames position + (v frameIndexFrom: from to: to) - 1 put: v label.
				v
					continue: frame
					from: from
					to: to
					framesDo: [ :f | 
						frame := f.
						frames nextPut: f ].
				v from: from to: to energiesDo: [ :e | energies nextPut: e ] ].
			path last continue: frame from: (path at: path size - 1) framesDo: [ :f | frames nextPut: f ].
			path last from: (path at: path size - 1) energiesDo: [ :e | energies nextPut: e ].
			labels at: frames position put: path last label ].
	^ Array
		with: (String streamContents: [ :stream | frames contents do: [ :xyz | xyz printXYZOn: stream ] ])
		with: labels
		with: energies contents