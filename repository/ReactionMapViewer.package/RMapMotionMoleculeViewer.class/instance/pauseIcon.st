user interface
pauseIcon
	^ pauseIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			form getCanvas
				line: 8 @ 7
					to: 8 @ 13
					width: 2
					color: Color black;
				line: 12 @ 7
					to: 12 @ 13
					width: 2
					color: Color black.
			pauseIcon := form ]