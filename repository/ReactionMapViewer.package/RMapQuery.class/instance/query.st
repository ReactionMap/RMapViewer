accessing
query
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