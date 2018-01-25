baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				configuration: 'Jun'
					with: [ 
							spec
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/tomooda/Jun4Pharo/main' ];
				yourself.
			spec
				configuration: 'Roassal2'
					with: [ 
							spec
								versionString: #stable;
								repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
				yourself.
			spec
				configuration: 'RTPDFExporter'
					with: [ 
							spec
								versionString: #development;
								repository: 'http://www.smalltalkhub.com/mc/azazael/RTPDFExporter/main' ];
				yourself.
			spec
				configuration: 'PolyMath'
					with: [ 
							spec
								version: '0.70';
								repository: 'http://smalltalkhub.com/mc/PolyMath/PolyMath/main' ];
				yourself.
			spec
				package: 'ReactionMapViewer' with: [ spec requires: #('Roassal2' 'Jun' 'PolyMath' 'RTPDFExporter') ];
				yourself.
			spec
				group: 'default' with: #('ReactionMapViewer');
				yourself ]