Extension { #name : #RTHTML5Exporter }

{ #category : #'*ReactionMapViewer' }
RTHTML5Exporter class >> export: view [
	| filename |
	filename := TRPlatform current dialogRequestSaveFilename: 'Export as html' extensions: #('html') path: nil.
	filename
		ifNil: [ 
			self inform: 'Saving cancelled'.
			^ self ].
	RTHTML5Exporter new
		directory: filename parent;
		fileName: filename basename;
		export: view
]
