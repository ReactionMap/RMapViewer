accessing-forms
plainLabelFormsFor: anRMapVertex
	| label color font lines form |
	label := anRMapVertex label.
	color := label first = $E
		ifTrue: [ Color lightGray ]
		ifFalse: [ Color white ].
	font := TextStyle default defaultFont.
	lines := (label subStrings: String cr) ifEmpty: [ Array with: anRMapVertex position printString ].
	form := Form
		extent:
			((lines inject: 0 into: [ :max :each | max max: (font widthOfString: each) ]) + 2) @ (lines size * font height + 2)
		depth: 32.
	form getCanvas
		in: [ :canvas | 
			canvas fillColor: color.
			lines
				keysAndValuesDo: [ :index :line | canvas drawString: line at: (((form width - (font widthOfString: line)) // 2) @ index - 1) * font height + 1 ] ].
	^ Array with: form