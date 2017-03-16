accessing-forms
underlineLabelFormsFor: anRMapVertex
	| label font lines form |
	label := anRMapVertex label.
	font := TextStyle default defaultFont.
	lines := (label subStrings: String cr) ifEmpty: [ Array with: anRMapVertex position printString ].
	form := Form
		extent:
			((lines inject: 0 into: [ :max :each | max max: (font widthOfString: each) ]) + 2) @ (lines size * font height * 2 + 2)
		depth: 32.
	form getCanvas
		in: [ :canvas | 
			canvas fillColor: Color transparent.
			lines
				keysAndValuesDo: [ :index :line | 
					canvas
						drawString: line
						at: ((form width - (font widthOfString: line)) // 2) @ ((index - 1) * font height + 1)
						font: font
						color: Color black ].
			canvas
				line: 0 @ (lines size * font height + 1)
				to: form width @ (lines size * font height + 1)
				width: 2
				color:
					(label first = $E
						ifTrue: [ Color blue ]
						ifFalse: [ 
							label first = $D
								ifTrue: [ Color green ]
								ifFalse: [ Color red ] ]) ].
	^ Array with: form