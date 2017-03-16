user interface
jumpToStartIcon
	^ jumpToStartIcon
		ifNil: [ 
			| form |
			form := Form extent: 20 @ 20 depth: 32.
			form getCanvas
				line: 4 @ 4
					to: 4 @ 15
					width: 1
					color: Color black;
				line: 5 @ 10
					to: 15 @ 10
					width: 1
					color: Color black;
				line: 5 @ 10
					to: 9 @ 8
					width: 1
					color: Color black;
				line: 6 @ 10
					to: 9 @ 8
					width: 1
					color: Color black;
				line: 5 @ 10
					to: 9 @ 12
					width: 1
					color: Color black;
				line: 6 @ 10
					to: 9 @ 12
					width: 1
					color: Color black.
			jumpToStartIcon := form ]