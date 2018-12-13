Class {
	#name : #RMap3dLargeGeometryRenderer,
	#superclass : #RMap3dGeometryRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMap3dLargeGeometryRenderer >> extent [
	| size |
	size := (rmap width * 1.4 * rmap viewScale / (rmap vertices size sqrt + 1)) truncated.
	^ size @ size
]

{ #category : #accessing }
RMap3dLargeGeometryRenderer >> name [
	^ '3D geometry (L)'
]
