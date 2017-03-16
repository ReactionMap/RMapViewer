initialize-release
initializeRenderers
	| eqDot dot edge plain geometry |
	eqDot := RMapEQDotRenderer on: self.
	dot := RMapDotRenderer on: self.
	edge := RMapEdgeRenderer on: self.
	plain := RMapPlainRenderer on: self.
	geometry := RMap3dSmallGeometryRenderer on: self.
	rendererSelector := RMapSelector new
		add:
				((RMapAdaptiveRenderer on: self)
						add: geometry maxNumVertices: 40;
						add: plain maxNumVertices: 100;
						add: edge maxNumVertices: 1000;
						add: dot maxNumVertices: Float infinity;
						yourself);
		add: eqDot;
		add: dot;
		add: edge;
		add: plain;
		add: (RMap3dLargeGeometryRenderer on: self);
		add: geometry;
		add: (RMapDepthRenderer on: self);
		add: (RMapAlphaRenderer on: self);
		add: (RMapUnderlineRenderer on: self);
		add: (RMap2dGeometryRenderer on: self);
		add: (RMap2dStructureRenderer on: self);
		add: (RMap2dStructure2Renderer on: self);
		add: (RMapGeometryRenderer on: self);
		add: (RMapEQGeometryRenderer on: self);
		add: (RMapEQGeometryUnderlineRenderer on: self);
		add: (RMapInfoRenderer on: self);
		addDependent: self;
		yourself.
	hoverRenderer := RMapNullRenderer on: self.
	selectionRenderer := nil