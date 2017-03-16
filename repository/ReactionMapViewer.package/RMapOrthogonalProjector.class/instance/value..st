accessing
value: anRMapVertex
	| w h scale x y |
	w := rmap width asFloat.
	h := rmap height asFloat.
	scale := w max: h.
	x := rmap xNumerizer value: anRMapVertex.
	x ifNil: [ ^ nil ].
	x := (x - rmap viewOffset x) * rmap viewScale * scale + (w // 2).
	y := rmap yNumerizer value: anRMapVertex.
	y ifNil: [ ^ nil ].
	y := (y - rmap viewOffset y) * rmap viewScale negated * scale + (h // 2).
	^ x @ y