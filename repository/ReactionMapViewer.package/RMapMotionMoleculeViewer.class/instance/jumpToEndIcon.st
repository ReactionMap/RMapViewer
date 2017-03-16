user interface
jumpToEndIcon
	^ jumpToEndIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			form getCanvas
				line: 15 @ 4
					to: 15 @ 15
					width: 1
					color: Color black;
				line: 5 @ 10
					to: 15 @ 10
					width: 1
					color: Color black;
				line: 15 @ 10
					to: 11 @ 8
					width: 1
					color: Color black;
				line: 14 @ 10
					to: 11 @ 8
					width: 1
					color: Color black;
				line: 15 @ 10
					to: 11 @ 12
					width: 1
					color: Color black;
				line: 15 @ 10
					to: 11 @ 12
					width: 1
					color: Color black.
			jumpToEndIcon := form ]