user interface
openFullInWorld
	| viewer |
	viewer := self buildViewer.
	self class isReleaseImage
		ifFalse: [ 
			^ viewer
				extent: 500 @ 500;
				openInWindowLabeled: 'RMapViewer' ].
	World submorphs copy do: [ :m | m delete ].
	World changeProportionalLayout.
	World addMorph: viewer fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1)).
	^ viewer