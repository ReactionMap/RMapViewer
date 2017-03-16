accessing
formsFor: anRMapVertex
	| color font lines form |
	color := Color white.
	font := TextStyle default defaultFont.
	lines := attributes collect: [ :attribute | attribute , ': ' , (anRMapVertex at: attribute ifAbsentPut: [ 'N/A' ]) asString ].
	(rmap hasReactant: anRMapVertex) ifTrue: [lines addFirst: 'Reactant'].
	(rmap hasProduct: anRMapVertex) ifTrue: [lines addFirst: 'Product'].
	form := Form
		extent:
			((lines inject: 0 into: [ :max :each | max max: (font widthOfString: each) ]) + 4) @ (lines size * font height + 4)
		depth: 32.
	form getCanvas
		in: [ :canvas | 
			canvas fillColor: color.
			canvas frameRectangle: (0 @ 0 corner: form extent) color: Color black.
			lines keysAndValuesDo: [ :index :line | canvas drawString: line at: 2 @ ((index - 1) * font height + 2) ] ].
	^ Array with: form