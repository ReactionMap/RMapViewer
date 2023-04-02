Class {
	#name : #BaselineOfRMapViewer,
	#superclass : #BaselineOf,
	#category : #BaselineOfRMapViewer
}

{ #category : #baseline }
BaselineOfRMapViewer >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Jun' with: [ 
				spec
					loads: 'Chemistry-Full';
					repository: 'github://tomooda/Jun:main/repository' ];
			baseline: 'GRMSD'
			with: [ 
			spec repository: 'github://ReactionMap/GRMSD-Pharo:main/src' ];
			baseline: 'Roassal3'
			with: [ spec repository: 'github://ObjectProfile/Roassal3:v1.0' ];
			baseline: 'Roassal3Exporters'
			with: [ 
			spec repository: 'github://ObjectProfile/Roassal3Exporters' ];
			baseline: 'NeoJSON'
			with: [ spec repository: 'github://svenvc/NeoJSON/repository' ];
			baseline: 'PolyMath'
			with: [ spec repository: 'github://PolyMathOrg/PolyMath/src' ];
			package: 'ReactionMapViewer' with: [ 
			spec requires:
				#( 'Jun' 'NeoJSON' 'Roassal3' 'Roassal3Exporters'
				   'PolyMath' 'GRMSD' ) ];
			postLoadDoIt: #postLoad;
			yourself.
		spec
			group: 'default' with: #( 'ReactionMapViewer' );
			yourself ]
]

{ #category : #activation }
BaselineOfRMapViewer >> postLoad [
	PharoLightTheme beCurrent.
	MenubarMorph closeAll.
	MenubarMorph new
		menuBarItems: RMapMorph menubarSpec items;
		open.
	RMapMorph openURL
]
