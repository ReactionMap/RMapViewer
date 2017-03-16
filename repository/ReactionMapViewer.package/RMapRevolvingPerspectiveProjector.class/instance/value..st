accessing
value: anRMapVertex
	| z dx dy w h scale x y |
	z := rmap zNumerizer value: anRMapVertex.
	z ifNil: [ ^ nil ].
	z := z + 1.0.
	r := self r.
	dx := theta cos * r / rmap viewScale.
	dy := theta sin * r / rmap viewScale.
	w := rmap width asFloat.
	h := rmap height asFloat.
	scale := w max: h.
	x := rmap xNumerizer value: anRMapVertex.
	x ifNil: [ ^ nil ].
	x := (x - rmap viewOffset x + dx) / z * rmap viewScale * scale + (w // 2).
	y := rmap yNumerizer value: anRMapVertex.
	y ifNil: [ ^ nil ].
	y := (y - rmap viewOffset y + dy) / z * rmap viewScale negated * scale + (h // 2).
	^ x @ y