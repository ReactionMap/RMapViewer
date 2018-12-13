Class {
	#name : #RMapMotionMolecule,
	#superclass : #JunMoleculeMotionGeometry,
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'class access' }
RMapMotionMolecule class >> moleculeClass [
	^ RMapMolecule
]

{ #category : #accessing }
RMapMotionMolecule >> e0 [
	^ moleculeGeometries ifEmpty: [ 0 ] ifNotEmpty: [ moleculeGeometries first energy ]
]

{ #category : #accessing }
RMapMotionMolecule >> eMax [
	^ moleculeGeometries ifEmpty: [ 0 ] ifNotEmpty: [ (moleculeGeometries collect: #energy) max ]
]

{ #category : #accessing }
RMapMotionMolecule >> eMin [
	^ moleculeGeometries ifEmpty: [ 0 ] ifNotEmpty: [ (moleculeGeometries collect: #energy) min ]
]

{ #category : #accessing }
RMapMotionMolecule >> energyAt: anInteger [
	^ (moleculeGeometries at: anInteger) energy
]

{ #category : #accessing }
RMapMotionMolecule >> labelAt: anInteger [
	^ (moleculeGeometries at: anInteger) label
]
