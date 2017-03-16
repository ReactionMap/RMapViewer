accessing
bounds
	| w h scale |
	w := rmap width asFloat.
	h := rmap height asFloat.
	scale := w @ h / rmap viewScale / (w max: h).
	^ rmap viewOffset - (scale / 2.0) extent: scale