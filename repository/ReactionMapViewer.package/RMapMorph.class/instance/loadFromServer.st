private
loadFromServer
	| client |
	client := (Smalltalk at: #RMapClient) on: self.
	client openWithSpec