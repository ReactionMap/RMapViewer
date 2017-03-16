accessing
getMenu: aMenu
	getMenuBlock ifNotNil: [ getMenuBlock value: aMenu ].
	^ aMenu