accessing
value: anRMapVertex
	| z w h scale x y |
	z := rmap zNumerizer value: anRMapVertex.
	z ifNil: [ ^nil ].
	z := z + 1.0.
	w := rmap width asFloat.
	h := rmap height asFloat.
	scale := w max: h.
	x := rmap xNumerizer value: anRMapVertex.
	x ifNil: [ ^ nil ].
	x := (x - rmap viewOffset x) / z * rmap viewScale * scale + (w // 2).
	y := rmap yNumerizer value: anRMapVertex.
	y ifNil: [ ^ nil ].
	y := (y - rmap viewOffset y) / z * rmap viewScale negated * scale + (h // 2).
	^ x @ y