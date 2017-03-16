drawing
drawOn: aCanvas
	| x y font style |
	font := self textStyle defaultFont.
	x := self bounds left.
	y := self bounds top + (self bounds height - font height // 2).
	style := self textStyle.
	text ifNotNil: [ 
		1 to: text size do: [  :index |
			| char f c |
			char := text at: index.
			f := text fontAt: index withStyle: style.
			c := Color black.
			text attributesAt: index do: [  :attr | (attr isKindOf: TextColor) ifTrue: [ c := attr color ] ].
			aCanvas drawString: (String with: char) at: x@y font: f color: c.
			x := x + (font widthOf: char)
		]
	]