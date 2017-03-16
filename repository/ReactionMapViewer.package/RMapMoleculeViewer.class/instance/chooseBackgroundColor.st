accessing
chooseBackgroundColor
	(UIManager default theme chooseColorIn: UIManager default title: 'Choose a background color' color: self color)
		ifNotNil: [ :c | self color: c ]