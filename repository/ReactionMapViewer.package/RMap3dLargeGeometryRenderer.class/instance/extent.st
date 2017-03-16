accessing
extent
	| size |
	size :=  rmap width * 1.4 * rmap viewScale / (rmap vertices size sqrt + 1).
	^ size @ size