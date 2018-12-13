Class {
	#name : #RMap3dSmallGeometryRenderer,
	#superclass : #RMap3dGeometryRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMap3dSmallGeometryRenderer >> extent [
	| size |
	size := (rmap width * (rmap viewScale * 0.8) / (rmap vertices size sqrt + 1)) truncated.
	^ size @ size
]

{ #category : #accessing }
RMap3dSmallGeometryRenderer >> name [
	^ '3D geometry (S)'
]
