*ReactionMapViewer
interactiveExportCanvas: view
	| filename |
	filename := TRPlatform current dialogRequestSaveFilename: 'Export as PDF' extensions: #('pdf') path: nil.
	filename
		ifNil: [ 
			self inform: 'Saving cancelled'.
			^ self ].
	self new
		stream: filename writeStream;
		exportCanvas: view