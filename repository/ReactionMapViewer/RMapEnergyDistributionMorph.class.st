Class {
	#name : #RMapEnergyDistributionMorph,
	#superclass : #Morph,
	#instVars : [
		'rmapMorph',
		'distribution'
	],
	#category : #'ReactionMapViewer-Morphs'
}

{ #category : #'instance creation' }
RMapEnergyDistributionMorph class >> on: anRMapMorph [
	^ self new
		setRMapMorph: anRMapMorph;
		yourself
]

{ #category : #'event handling' }
RMapEnergyDistributionMorph >> click: anEvent [
	self grab: anEvent
]

{ #category : #'submorphs-add/remove' }
RMapEnergyDistributionMorph >> delete [
	rmapMorph
		ifNotNil: [ 
			rmapMorph removeDependent: self.
			rmapMorph := nil ].
	super delete
]

{ #category : #drawing }
RMapEnergyDistributionMorph >> drawOn: aCanvas [
	aCanvas fillRectangle: self bounds color: (Color gray: 0.8).
	(self yAtEnergy: self lowerBound)
		in: [ :maxY | 
			(self yAtEnergy: self upperBound)
				in: [ :minY | aCanvas fillRectangle: (self left @ minY corner: self right @ maxY) color: Color white ] ].
	((1 to: distribution size)
		collect: [ :index | 
			| x y |
			x := (distribution at: index) * self width + self left.
			y := self bottom - (self height * (index - 1.0) / distribution size).
			x @ y ])
		in: [ :points | 
			1 to: points size - 1 do: [ :index | 
				| p1 p2 |
				p1 := points at: index.
				p2 := points at: index + 1.
				aCanvas
					drawPolygon:
						(Array
							with: self left @ p1 y
							with: p1
							with: p2
							with: self left @ p2 y)
					fillStyle: Color gray.
				aCanvas line: p1 to: p2 color: Color black ] ]
]

{ #category : #accessing }
RMapEnergyDistributionMorph >> energyAt: aPoint [ 
	^ self energyAtY: aPoint y
]

{ #category : #accessing }
RMapEnergyDistributionMorph >> energyAtY: aNumber [
	^ (self bottom - aNumber) asFloat * (self max - self min) / (self height - 1) + self min
]

{ #category : #'event handling' }
RMapEnergyDistributionMorph >> grab: anEvent [
	anEvent position
		in: [ :p | 
			| energy |
			energy := self energyAt: p.
			(energy - self lowerBound) abs < (energy - self upperBound) abs
				ifTrue: [ self lowerBound: energy ]
				ifFalse: [ self upperBound: energy ] ]
]

{ #category : #'event handling' }
RMapEnergyDistributionMorph >> handlesMouseDown: event [
	^ true
]

{ #category : #initialize }
RMapEnergyDistributionMorph >> initialize [
	super initialize.
	distribution := Array new: 100 withAll: 0
]

{ #category : #accessing }
RMapEnergyDistributionMorph >> lowerBound [
	^ rmapMorph visibleEnergyRangeMin
]

{ #category : #accessing }
RMapEnergyDistributionMorph >> lowerBound: aNumber [
	rmapMorph visibleEnergyRangeMin: (rmapMorph energyRangeMin max: aNumber).
	self changed
]

{ #category : #accessing }
RMapEnergyDistributionMorph >> max [
	^ rmapMorph energyRangeMax
]

{ #category : #accessing }
RMapEnergyDistributionMorph >> min [
	^ rmapMorph energyRangeMin
]

{ #category : #'event handling' }
RMapEnergyDistributionMorph >> mouseDown: event [ 
	event hand waitForClicksOrDrag: self event: event
]

{ #category : #'event handling' }
RMapEnergyDistributionMorph >> mouseMove: anEvent [
	self grab: anEvent
]

{ #category : #private }
RMapEnergyDistributionMorph >> setRMapMorph: anRMapMorph [
	rmapMorph := anRMapMorph.
	rmapMorph addDependent: self.
	self updateDistribution
]

{ #category : #updating }
RMapEnergyDistributionMorph >> update: aSymbol [
	(aSymbol = #visibleEnergyRangeMin or: [ aSymbol = #visibleEnergyRangeMax ])
		ifTrue: [ self changed ].
	aSymbol = #rmap
		ifTrue: [ self updateDistribution ]
]

{ #category : #private }
RMapEnergyDistributionMorph >> updateDistribution [

	rmapMorph
		ifNil: [ distribution := Array new: 100 withAll: 0 ]
		ifNotNil: [ 
			| tmpMin tmpMax a tmpDistribution peak |
			tmpMin := rmapMorph energyRangeMin.
			tmpMax := rmapMorph energyRangeMax.
			a := 100.0 / (tmpMax - tmpMin) asFloat.
			tmpDistribution := Array new: 100 withAll: 0.
			rmapMorph verticesDo: [ :vertex | 
				| index |
				index := (vertex energy - tmpMin * a) floor + 1 min: 100 max: 1.
				tmpDistribution at: index put: (tmpDistribution at: index) + 1 ].
			peak := tmpDistribution max asFloat.
			peak <= Float fmin ifTrue: [ peak := 1.0 ].
			distribution := tmpDistribution collect: [ :num | 
				                num asFloat / peak ] ].
	self changed
]

{ #category : #accessing }
RMapEnergyDistributionMorph >> upperBound [
	^ rmapMorph visibleEnergyRangeMax
]

{ #category : #accessing }
RMapEnergyDistributionMorph >> upperBound: aNumber [
	rmapMorph visibleEnergyRangeMax: (rmapMorph energyRangeMax min: aNumber).
	self changed
]

{ #category : #accessing }
RMapEnergyDistributionMorph >> yAtEnergy: aNumber [
	| y |
	y := self bottom - ((self height - 1) * (aNumber - self min) / (self max - self min)) asFloat.
	y isNaN
		ifTrue: [ y := 0 ].
	^ y
]
