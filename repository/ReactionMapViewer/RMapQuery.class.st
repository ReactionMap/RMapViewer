Class {
	#name : #RMapQuery,
	#superclass : #ComposableModel,
	#instVars : [
		'nameField',
		'commandField',
		'methodField',
		'basisField',
		'compositionTable'
	],
	#category : 'ReactionMapViewer-Client'
}

{ #category : #specs }
RMapQuery class >> defaultSpec [
	<script: 'RMapQuery new openDialogWithSpec title: ''RMapServer query'''>
	<spec>
	^ SpecLayout composed
		newColumn: [ :c | 
					c
						newRow: [ :r | 
									r
										add: #nameField;
										yourself ]
							height: 20;
						newRow: [ :r | 
									r
										add: #commandField;
										add: #methodField;
										add: #basisField;
										yourself ]
							height: 20;
						newRow: [ :r | 
									r
										add: #compositionTable;
										yourself ] ]
			width: 300;
		yourself
]

{ #category : #menus }
RMapQuery >> addElementInComposition [
	| element quantity |
	element := JunPeriodicTableMorph chooseAnAtomClass symbol.
	quantity := UIManager default chooseFrom: (0 to: 99) asArray title: 'quantity'.
	quantity ifNotNil: [ self setElement: element quantity: (quantity - 1) asString ]
]

{ #category : #accessing }
RMapQuery >> basisField [
	^ basisField
]

{ #category : #accessing }
RMapQuery >> basisField: anObject [
	basisField := anObject
]

{ #category : #accessing }
RMapQuery >> commandField [
	^ commandField
]

{ #category : #accessing }
RMapQuery >> commandField: anObject [
	commandField := anObject
]

{ #category : #menus }
RMapQuery >> compositionMenu: aMenu shifted: aBoolean [
	self compositionTable selectedItem
		ifNil: [ aMenu add: 'add' target: self selector: #addElementInComposition ]
		ifNotNil: [ 
			aMenu
				add: 'set quantity' target: self selector: #setQuantityInComposition;
				add: 'remove' target: self selector: #removeElementInComposition ].
	^ aMenu
]

{ #category : #accessing }
RMapQuery >> compositionTable [
	^ compositionTable
]

{ #category : #accessing }
RMapQuery >> compositionTable: anObject [
	compositionTable := anObject
]

{ #category : #initialization }
RMapQuery >> initializeWidgets [
	nameField := self newTextInput.
	nameField removeEntryCompletion.
	nameField ghostText: 'Name of reaction map'.
	nameField autoAccept: true.
	commandField := self newTextInput.
	commandField removeEntryCompletion.
	commandField ghostText: 'grrm command'.
	commandField autoAccept: true.
	methodField := self newTextInput.
	methodField removeEntryCompletion.
	methodField ghostText: 'method'.
	methodField autoAccept: true.
	basisField := self newTextInput.
	basisField removeEntryCompletion.
	basisField ghostText: 'basis'.
	basisField autoAccept: true.
	compositionTable := self newMultiColumnList.
	compositionTable
		displayBlock: [ :assoc | 
			{(assoc key).
			(assoc value)} ].
	compositionTable
		sortingBlock: [ :less :more | 
					(#('C' 'H' 'O') includes: less key)
						ifTrue: [ 
							(#('C' 'H' 'O') includes: more key)
								ifTrue: [ less key <= more key ]
								ifFalse: [ true ] ]
						ifFalse: [ 
							(#('C' 'H' 'O') includes: more key)
								ifTrue: [ false ]
								ifFalse: [ less key <= more key ] ] ];
		items:
				{('C' -> '').
					('H' -> '').
					('O' -> '')};
		menu: [ :m :s | self compositionMenu: m shifted: s ]
]

{ #category : #accessing }
RMapQuery >> methodField [
	^ methodField
]

{ #category : #accessing }
RMapQuery >> methodField: anObject [
	methodField := anObject
]

{ #category : #accessing }
RMapQuery >> nameField [
	^ nameField
]

{ #category : #accessing }
RMapQuery >> nameField: anObject [
	nameField := anObject
]

{ #category : #accessing }
RMapQuery >> query [
	| meta |
	meta := Dictionary new.
	nameField getText asString trim ifNotEmpty: [ :name | meta at: 'name' put: name ].
	commandField getText asString trim ifNotEmpty: [ :command | meta at: 'command1' put: command ].
	methodField getText asString trim ifNotEmpty: [ :method | meta at: 'command2' put: method ].
	basisField getText asString trim ifNotEmpty: [ :basis | meta at: 'command3' put: basis ].
	compositionTable getList
		do: [ :assoc | 
			assoc key asString trim
				ifNotEmpty: [ :element | assoc value asString trim ifNotEmpty: [ :num | meta at: 'atoms.' , element put: num ] ] ].
	^ meta
]

{ #category : #menus }
RMapQuery >> removeElementInComposition [
	| element |
	element := self compositionTable selectedItem key.
	(#('C' 'H' 'O') includes: element)
		ifTrue: [ self setElement: element quantity: '' ]
		ifFalse: [ self compositionTable items: (self compositionTable listItems reject: [ :assoc | assoc key = element ]) ]
]

{ #category : #menus }
RMapQuery >> setElement: elementString quantity: quantityString [
	| assocs |
	assocs := self compositionTable listItems.
	assocs := (assocs reject: [ :assoc | assoc key = elementString ]) copyWith: elementString -> quantityString.
	self compositionTable items: assocs
]

{ #category : #menus }
RMapQuery >> setQuantityInComposition [
	| element quantity |
	element := self compositionTable selectedItem key.
	quantity := UIManager default chooseFrom: (0 to: 99) asArray title: 'quantity'.
	quantity ifNotNil: [ self setElement: element quantity: (quantity - 1) asString ]
]
