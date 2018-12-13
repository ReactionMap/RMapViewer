Class {
	#name : #RMapProjector,
	#superclass : #Object,
	#instVars : [
		'rmap'
	],
	#category : 'ReactionMapViewer-Projectors'
}

{ #category : #'instance creation' }
RMapProjector class >> on: anRMapMorph [
	^ self new
		rmap: anRMapMorph;
		yourself
]

{ #category : #accessing }
RMapProjector >> bounds [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMapProjector >> name [
	^ self subclassResponsibility
]

{ #category : #printing }
RMapProjector >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #accessing }
RMapProjector >> rmap [
	^ rmap
]

{ #category : #accessing }
RMapProjector >> rmap: anRMapMorph [
	rmap := anRMapMorph
]

{ #category : #stepping }
RMapProjector >> step [
	"do nothing by default"
]

{ #category : #accessing }
RMapProjector >> update [
	" do nothing by default"
]

{ #category : #accessing }
RMapProjector >> updateSelection [
	
]

{ #category : #accessing }
RMapProjector >> value0: anRMapVertex [
	^ self value: anRMapVertex
]

{ #category : #accessing }
RMapProjector >> value: anRMapVertex [
	^ self subclassResponsibility
]
