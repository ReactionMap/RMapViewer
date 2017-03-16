user interface
openInWindowLabeled: aString
	| viewer |
	viewer := self buildViewer.
	viewer extent: World extent * 0.8.
	^ viewer openInWindowLabeled: aString