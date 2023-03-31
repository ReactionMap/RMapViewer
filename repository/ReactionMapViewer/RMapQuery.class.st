Class {
	#name : #RMapQuery,
	#superclass : #SpPresenter,
	#instVars : [
		'nameField',
		'commandField',
		'methodField',
		'basisField',
		'compositionTable'
	],
	#category : #'ReactionMapViewer-Client'
}

{ #category : #specs }
RMapQuery class >> defaultSpec [

	<script:
	'RMapQuery new openDialogWithSpec title: ''RMapServer query'''>
	<spec>
	^ SpBoxLayout newHorizontal
		  add: (SpBoxLayout newVertical
				   add: #nameField expand: false;
				   add: (SpBoxLayout newHorizontal
						    add: #commandField;
						    add: #methodField;
						    add: #basisField;
						    yourself)
				   expand: false;
				   add: #compositionTable;
				   yourself)
		  width: 300
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
RMapQuery >> compositionMenu [

	| menu |
	menu := self newMenu.
	self compositionTable selectedItem
		ifNil: [ 
			menu addItem: [ :item | 
				item
					name: 'add';
					action: [ self addElementInComposition ] ] ]
		ifNotNil: [ 
			menu
				addItem: [ :item | 
					item
						name: 'set quantity';
						action: [ self selector: #setQuantityInComposition ] ];
				addItem: [ :item | 
					item
						name: 'remove';
						action: [ self selector: #removeElementInComposition ] ] ].
	^ menu
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
RMapQuery >> initializePresenters [

	nameField := self newTextInput.
	nameField removeEntryCompletion.
	nameField placeholder: 'Name of reaction map'.
	nameField autoAccept: true.
	commandField := self newTextInput.
	commandField removeEntryCompletion.
	commandField placeholder: 'grrm command'.
	commandField autoAccept: true.
	methodField := self newTextInput.
	methodField removeEntryCompletion.
	methodField placeholder: 'method'.
	methodField autoAccept: true.
	basisField := self newTextInput.
	basisField removeEntryCompletion.
	basisField placeholder: 'basis'.
	basisField autoAccept: true.
	compositionTable := self newTable.
	compositionTable
		hideColumnHeaders;
		addColumn: (SpStringTableColumn evaluated: #key);
		addColumn: (SpStringTableColumn evaluated: #value).
	compositionTable
		sortingBlock: [ :less :more | 
			(#( 'C' 'H' 'O' ) includes: less key)
				ifTrue: [ 
					(#( 'C' 'H' 'O' ) includes: more key)
						ifTrue: [ less key <= more key ]
						ifFalse: [ true ] ]
				ifFalse: [ 
					(#( 'C' 'H' 'O' ) includes: more key)
						ifTrue: [ false ]
						ifFalse: [ less key <= more key ] ] ];
		items: { 
				('C' -> '').
				('H' -> '').
				('O' -> '') };
		contextMenu: [ self compositionMenu ]
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
	nameField text asString trim ifNotEmpty: [ :name | 
		meta at: 'name' put: name ].
	commandField text asString trim ifNotEmpty: [ :command | 
		meta at: 'command1' put: command ].
	methodField text asString trim ifNotEmpty: [ :method | 
		meta at: 'command2' put: method ].
	basisField text asString trim ifNotEmpty: [ :basis | 
		meta at: 'command3' put: basis ].
	compositionTable items do: [ :assoc | 
		assoc key asString trim ifNotEmpty: [ :element | 
			assoc value asString trim ifNotEmpty: [ :num | 
				meta at: 'atoms.' , element put: num ] ] ].
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
