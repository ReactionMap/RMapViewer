private
openTreeViewer
	| topNode agenda done links extraLinks renderer icons b |
	topNode := vertices argmin: #energy.
	agenda := Array with: nil -> topNode.
	done := IdentitySet new: self vertices size.
	done add: topNode.
	links := Array new writeStream.
	extraLinks := Array new writeStream.
	[ agenda notEmpty ]
		whileTrue: [ 
			| newAgenda |
			newAgenda := Array new writeStream.
			agenda
				do: [ :assoc | 
					| node |
					links nextPut: assoc.
					node := assoc value.
					node
						neighborsDo: [ :next | 
							(done includes: next)
								ifTrue: [ extraLinks nextPut: node -> next ]
								ifFalse: [ 
									done add: next.
									newAgenda nextPut: node -> next ] ] ].
			agenda := newAgenda contents ].
	links := links contents.
	extraLinks := extraLinks contents.
	extraLinks := extraLinks reject: [ :assoc | links includes: assoc value -> assoc key ].
	renderer := RMap3dLargeGeometryRenderer new.
	icons := IdentityDictionary new.
	links
		do: [ :assoc | 
			| vertex icon |
			vertex := assoc value.
			icon := Form extent: 100 @ 100 depth: 32.
			icon getCanvas
				fillColor: Color white;
				paintImage: (renderer formsFor: vertex extent: 100 @ 100) first at: 0 @ 0.
			icons at: vertex put: icon ].
	b := RTMondrian new.
	b shape
		shape: (RTBitmap new form: [ :v | icons at: v ]);
		withTextAbove: #label;
		withTextBelow: [ :v | v kJpermol - topNode kJpermol printShowingDecimalPlaces: 2 ].
	b nodes: (links collect: #value).
	b shape line.
	b edges fromAssociations: links.
	b layout tree.
	b shape
		shape: RMapTreeViewBezierLine new;
		color: (Color blue alpha: 0.5).
	b edges fromAssociations: extraLinks.
	b build.
	b view openInWindowSized: self extent titled: 'Reaction Tree View'