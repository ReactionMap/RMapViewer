drawing
renderAngleMeasure: aJunRenderingContext
	| atom1 atom2 atom3 v1 v2 |
	atom1 := atoms first.
	atom2 := atoms second.
	atom3 := atoms third.
	v1 := (atom1 position - atom2 position) unitVector * 0.5.
	v2 := (atom3 position - atom2 position) unitVector * 0.5.
	aJunRenderingContext
		disableLighting;
		disableDepthTest;
		color: Color yellow;
		displayLines:
				{(atom1 position + v1).
					(atom2 position)};
		displayLines:
				{(atom3 position + v2).
					(atom2 position)};
		enableLighting;
		enableDepthTest