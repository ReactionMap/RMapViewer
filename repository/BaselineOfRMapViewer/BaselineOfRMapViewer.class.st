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
				baseline: 'PolyMath' with: [ spec repository: 'github://PolyMathOrg/PolyMath/src' ];
				package: 'ReactionMapViewer'
					with: [ spec requires: #('Jun' 'NeoJSON' 'Roassal2' 'PolyMath') ];
				yourself.
			spec
				group: 'default' with: #('ReactionMapViewer');
				yourself ]
]
