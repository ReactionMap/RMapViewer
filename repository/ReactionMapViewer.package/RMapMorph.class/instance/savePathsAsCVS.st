private
savePathsAsCVS
	(UITheme current
		fileSaveIn: World
		title: 'foo'
		extensions: #('cvs')
		path: FileSystem workingDirectory parent parent parent fullName)
		ifNotNil: [ :fileReference | 
			fileReference
				writeStreamDo: [ :stream | stream ascii. paths do: [ :path | stream nextPutAll: (self cvsForPath: path) ] separatedBy: [ stream lf ] ] ]