Class {
	#name : #BaselineOfRMapViewer,
	#superclass : #BaselineOf,
	#category : #BaselineOfRMapViewer
}

{ #category : #baseline }
BaselineOfRMapViewer >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Jun' with: [ spec repository: 'github://tomooda/Jun/repository' ];
				yourself.
			spec
				configuration: 'Roassal2'
					with: [ spec
						versionString: #stable;
						repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
				yourself.
			spec
				configuration: 'RTPDFExporter'
					with: [ spec
						versionString: #development;
						repository: 'http://www.smalltalkhub.com/mc/azazael/RTPDFExporter/main' ];
				yourself.
			spec
				configuration: 'PolyMath'
					with: [ spec
						version: '0.70';
						repository: 'http://smalltalkhub.com/mc/PolyMath/PolyMath/main' ];
				yourself.
			spec
				package: 'ReactionMapViewer'
					with: [ spec requires: #('Jun' 'Roassal2' 'PolyMath' 'RTPDFExporter') ];
				yourself.
			spec
				group: 'default' with: #('ReactionMapViewer');
				yourself ]
]
