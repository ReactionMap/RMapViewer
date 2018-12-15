Class {
	#name : #RMap2dGeometryRenderer,
	#superclass : #RMapGeometryRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMap2dGeometryRenderer >> centroidX: anRMapVertex [
	| cx  |
	cx := 0.0.
	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			cx := cx + x].
	^ cx / anRMapVertex geometry size asFloat
]

{ #category : #accessing }
RMap2dGeometryRenderer >> centroidY: anRMapVertex [
	| cy  |
	cy := 0.0.

	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			cy := cy + y].
	^ cy / anRMapVertex geometry size asFloat
]

{ #category : #accessing }
RMap2dGeometryRenderer >> centroidZ: anRMapVertex [
	| cz  |
	cz := 0.0.
	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			cz := cz + z].
	^ cz / anRMapVertex geometry size asFloat
]

{ #category : #accessing }
RMap2dGeometryRenderer >> formsFor: anRMapVertex [
	| atoms positions zs offset extent form font |
	atoms := OrderedCollection new: anRMapVertex geometry size.
	positions := OrderedCollection new: anRMapVertex geometry size.
	zs := OrderedCollection new: anRMapVertex geometry size.
	self
		geometry2d: anRMapVertex
		do: [ :atom :x :y :z | 
			atoms add: atom.
			positions add: x @ y.
			zs add: z ].
	offset := positions min - 1.
	positions := positions collect: [ :p | (p - offset) * atomDiameter ].
	font := TextStyle default defaultFont.
	extent := 0 @ font height + atomDiameter + positions max.
	form := Form extent: extent depth: 32.
	form fillColor: Color white.
	form getCanvas
		in: [ :canvas | 
			anRMapVertex
				bondsDo: [ :a1 :a2 :type | 
					type odd
						ifTrue: [ 
							type to: 1 by: -1 do: [ :i | 
								| p1 p2 v |
								p1 := positions at: a1.
								p2 := positions at: a2.
								v := p2 - p1.
								v := (4.0 + (i * 2 - 1)) / v r * v.
								canvas
									line: p1
									to: p2
									width: i * 2 - 1
									color:
										(i odd
											ifTrue: [ Color black ]
											ifFalse: [ Color white ]) ] ]
						ifFalse: [ 
							type to: 1 by: -1 do: [ :i | 
								| p1 p2 v |
								p1 := positions at: a1.
								p2 := positions at: a2.
								v := p2 - p1.
								v := (4.0 + (i * 2 - 1)) / v r * v.
								canvas
									line: p1
									to: p2
									width: i * 2 - 1
									color:
										(i even
											ifTrue: [ Color black ]
											ifFalse: [ Color white ]) ] ] ].
			((1 to: positions size) asSortedCollection: [ :less :more | (zs at: less) <= (zs at: more) ])
				do: [ :i | 
					| r |
					r := atomDiameter * 0.7.
					canvas
						fillOval: ((positions at: i) - (r / 2.0) extent: r asPoint)
						color: (self atomColorAt: (atoms at: i))
						borderWidth: 1
						borderColor: Color black ].
			canvas
				drawString: anRMapVertex label
				at: ((form width - (font widthOfString: anRMapVertex label)) // 2) @ (form height - font height - 2).
			canvas frameRectangle: (0 @ 0 extent: form extent) color: Color lightGray ].
	^ Array with: form
]

{ #category : #accessing }
RMap2dGeometryRenderer >> geometry2d: anRMapVertex do: aBlock [
	| a f f1 f2 f3 |
	a := PMMatrix rows: (self geometryMatrix: anRMapVertex).
	f := (a transpose * a) orthogonalize.
	f1 := f numberOfColumns >= 1
		ifTrue: [ f columnAt: 1 ]
		ifFalse: [ PMVector with: 0.0 with: 0.0 with: 0.0 ].
	f2 := f numberOfColumns >= 2
		ifTrue: [ f columnAt: 2 ]
		ifFalse: [ PMVector with: 0.0 with: 0.0 with: 0.0 ].
	f3 := f numberOfColumns >= 3
		ifTrue: [ f columnAt: 3 ]
		ifFalse: [ PMVector with: 0.0 with: 0.0 with: 0.0 ].
	anRMapVertex
		geometryDo: [ :atom :x :y :z | 
			| v |
			v := PMVector with: x with: y with: z.
			aBlock
				value: atom
				value: f1 * v
				value: f2 * v
				value: f3 * v ]
]

{ #category : #accessing }
RMap2dGeometryRenderer >> geometryMatrix: anRMapVertex [
	| matrix cx cy cz |
	matrix := (Array new: anRMapVertex geometry size) writeStream.
	cx := self centroidX: anRMapVertex.
	cy := self centroidY: anRMapVertex.
	cz := self centroidZ: anRMapVertex.
	anRMapVertex geometryDo: [ :atom :x :y :z | matrix nextPut: (Array with: x - cx with: y - cy with: z - cz) ].
	^ matrix contents
]

{ #category : #'initialize-release' }
RMap2dGeometryRenderer >> initialize [
	super initialize.
	atomDiameter := 15.0.
]

{ #category : #accessing }
RMap2dGeometryRenderer >> name [
	^ '2D geometry'
]
