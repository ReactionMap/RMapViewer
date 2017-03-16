accessing
extent
	| size |
	size := rmap width * (rmap viewScale * 0.8) / (rmap vertices size sqrt + 1).
	^ size @ size