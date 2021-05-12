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
				baseline: 'Jun'
					with: [ spec
						loads: 'Chemistry-Full';
						repository: 'github://tomooda/Jun:main/repository' ];
				baseline: 'Roassal2'
					with: [ spec
						loads: 'NoGlamour';
						repository: 'github://ObjectProfile/Roassal2/src' ];
				baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ];
				baseline: 'PolyMath' with: [ spec repository: 'github://PolyMathOrg/PolyMath/src' ];
				package: 'ReactionMapViewer'
					with: [ spec requires: #('Jun' 'NeoJSON' 'Roassal2' 'PolyMath') ];
				yourself.
			spec
				group: 'default' with: #('ReactionMapViewer');
				yourself ]
]
