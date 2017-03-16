accessing
pointFromT: t energy: e
	^ (t * scaleX + offsetX) @ ((e - eMin) * scaleY + offsetY)