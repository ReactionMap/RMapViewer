drawing
renderDistanceMeasure: aJunRenderingContext
	| atom1 atom2 v |
	atom1 := atoms first.
	atom2 := atoms second.
	v := (atom2 position - atom1 position crossProduct: projection sightVector) unitVector * 0.5.
	aJunRenderingContext
		disableLighting;
		disableDepthTest;
		color: Color yellow;
		displayLines:
				{(atom1 position).
					(atom1 position + v)};
		displayLines:
				{(atom2 position).
					(atom2 position + v)};
		displayLines:
				{(atom1 position + (v * 0.8)).
					(atom2 position + (v * 0.8))};
		enableLighting;
		enableDepthTest