drawing
renderDihedralAngleMeasure: aJunRenderingContext
	| atom1 atom2 atom3 atom4 |
	atom1 := atoms first.
	atom2 := atoms second.
	atom3 := atoms third.
	atom4 := atoms fourth.
	aJunRenderingContext
		disableLighting;
		disableCullface;
		color: (Color blue alpha: 0.5);
		displayPolygon:
				{(atom1 position).
					(atom2 position).
					(atom3 position)};
		color: (Color yellow alpha: 0.5);
		displayPolygon:
				{(atom2 position).
					(atom3 position).
					(atom4 position)};
		enableCullface;
		disableDepthTest;
		color: Color blue;
		displayLines:
				{(atom1 position).
					(atom2 position)};
		displayLines:
				{(atom3 position).
					(atom1 position)};
		color: Color yellow;
		displayLines:
				{(atom3 position).
					(atom4 position)};
		displayLines:
				{(atom4 position).
					(atom2 position)};
		color: Color cyan;
		displayLines:
				{(atom2 position).
					(atom3 position)};
		enableDepthTest;
		enableLighting