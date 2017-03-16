adding
geometryAdd: anArray
	^ geometry
		add:
			{(anArray first asString).
			(anArray second asNumber asFloat).
			(anArray third asNumber asFloat).
			(anArray fourth asNumber asFloat)}