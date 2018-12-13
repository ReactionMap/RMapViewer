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
				configuration: 'Roassal2'
					with: [ spec
						versionString: #stable;
						repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
				baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ];
				configuration: 'RTPDFExporter'
					with: [ spec
						versionString: #development;
						repository: 'http://www.smalltalkhub.com/mc/azazael/RTPDFExporter/main' ];
				configuration: 'PolyMath'
					with: [ spec
						version: '0.70';
						repository: 'http://smalltalkhub.com/mc/PolyMath/PolyMath/main' ];
				package: 'ReactionMapViewer'
					with: [ spec requires: #('Jun' 'NeoJSON' 'Roassal2' 'PolyMath' 'RTPDFExporter') ];
				yourself.
			spec
				group: 'default' with: #('ReactionMapViewer');
				yourself ]
]
