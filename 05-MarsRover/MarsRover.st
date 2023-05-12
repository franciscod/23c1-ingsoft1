!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 16:48:23'!
test01MarsRoverStartsOnInitializedPosition
	| mr |
	
	mr := MarsRover startsOn: 4@2 facing: #Norte.
	
	self assert: 4@2 equals: mr position
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 16:49:12'!
test02MarsRoverStartsOnInitializedDirection
	| mr |
	
	mr := MarsRover startsOn: 4@2 facing: #Norte.
	
	self assert: #Norte equals: mr direction
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 16:54:02'!
test03MarsRoverDoesNotMoveOnEmptySetOfCommands
	| mr commands |
	
	commands := ''.
	
	mr := MarsRover startsOn: 4@2 facing: #Norte.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@2 andDirection: #Norte.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:27:24'!
test04MarsRoverMovesForwardOnCommandWhenFacingNorth
	| mr commands |
	
	commands := 'f'.
	
	mr := MarsRover startsOn: 4@2 facing: #North.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@3 andDirection: #North.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:27:28'!
test05MarsRoverMovesBackwardOnCommandWhenFacingNorth
	| mr commands |
	
	commands := 'b'.
	
	mr := MarsRover startsOn: 4@2 facing: #North.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@1 andDirection: #North.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:27:37'!
test06MarsRoverRotatesLeftOnCommandWhenFacingNorth
	| mr commands |
	
	commands := 'l'.
	
	mr := MarsRover startsOn: 4@2 facing: #North.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@2 andDirection: #West.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:27:46'!
test07MarsRoverRotatesRightOnCommandWhenFacingNorth
	| mr commands |
	
	commands := 'r'.
	
	mr := MarsRover startsOn: 4@2 facing: #North.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@2 andDirection: #East.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:26:14'!
test08MarsRoverMovesForwardOnCommandWhenFacingEast
	| mr commands |
	
	commands := 'f'.
	
	mr := MarsRover startsOn: 4@2 facing: #East.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 5@2 andDirection: #East.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:25:35'!
test09MarsRoverMovesBackwardOnCommandWhenFacingEast
	| mr commands |
	
	commands := 'b'.
	
	mr := MarsRover startsOn: 4@2 facing: #East.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 3@2 andDirection: #East.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:30:12'!
test10MarsRoverRotatesLeftOnCommandWhenFacingEast
	| mr commands |
	
	commands := 'l'.
	
	mr := MarsRover startsOn: 4@2 facing: #East.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@2 andDirection: #North.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:30:42'!
test11MarsRoverRotatesRightOnCommandWhenFacingEast
	| mr commands |
	
	commands := 'r'.
	
	mr := MarsRover startsOn: 4@2 facing: #East.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@2 andDirection: #South.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:32:13'!
test12MarsRoverMovesForwardOnCommandWhenFacingWest
	| mr commands |
	
	commands := 'f'.
	
	mr := MarsRover startsOn: 4@2 facing: #West.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 3@2 andDirection: #West.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:32:35'!
test13MarsRoverMovesBackwardOnCommandWhenFacingWest
	| mr commands |
	
	commands := 'b'.
	
	mr := MarsRover startsOn: 4@2 facing: #West.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 5@2 andDirection: #West.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:34:27'!
test14MarsRoverRotatesLeftOnCommandWhenFacingWest
	| mr commands |
	
	commands := 'l'.
	
	mr := MarsRover startsOn: 4@2 facing: #West.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@2 andDirection: #South.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:34:51'!
test15MarsRoverRotatesRightOnCommandWhenFacingWest
	| mr commands |
	
	commands := 'r'.
	
	mr := MarsRover startsOn: 4@2 facing: #West.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@2 andDirection: #North.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:36:18'!
test16MarsRoverMovesForwardOnCommandWhenFacingSouth
	| mr commands |
	
	commands := 'f'.
	
	mr := MarsRover startsOn: 4@2 facing: #South.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@1 andDirection: #South.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:36:46'!
test17MarsRoverMovesBackwardOnCommandWhenFacingSouth
	| mr commands |
	
	commands := 'b'.
	
	mr := MarsRover startsOn: 4@2 facing: #South.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@3 andDirection: #South.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:37:40'!
test18MarsRoverRotatesLeftOnCommandWhenFacingSouth
	| mr commands |
	
	commands := 'l'.
	
	mr := MarsRover startsOn: 4@2 facing: #South.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@2 andDirection: #East.
	
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:37:35'!
test19MarsRoverRotatesRightOnCommandWhenFacingSouth
	| mr commands |
	
	commands := 'r'.
	
	mr := MarsRover startsOn: 4@2 facing: #South.
	
	mr processCommands: commands.
	
	self assertMarsRover: mr hasPosition: 4@2 andDirection: #West.
	
	! !


!MarsRoverTest methodsFor: 'testing' stamp: 'JV 5/12/2023 16:56:20'!
assertMarsRover: aMarsRover hasPosition: aPosition andDirection: aDirection 
	self assert: ((aMarsRover position = aPosition) and: (aMarsRover direction = aDirection))! !


!classDefinition: #Direction category: 'MarsRover'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Direction methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:15'!
nextPointBackwardFrom: aPoint
	self opposite nextPointForwardFrom: aPoint! !

!Direction methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:24'!
nextPointForwardFrom: aPoint
	self subclassResponsibility ! !

!Direction methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:35'!
opposite
	self subclassResponsibility ! !

!Direction methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:09'!
rotatedLeft90Degrees
	self subclassResponsibility ! !

!Direction methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:20'!
rotatedRight90Degrees
	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:13'!
nextPointBackwardFrom: aPoint
	self opposite nextPointForwardFrom: aPoint! !

!East methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:22'!
nextPointForwardFrom: aPoint
	self subclassResponsibility ! !

!East methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:33'!
opposite
	self subclassResponsibility ! !

!East methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:08'!
rotatedLeft90Degrees
	self subclassResponsibility ! !

!East methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:18'!
rotatedRight90Degrees
	self subclassResponsibility ! !


!classDefinition: #North category: 'MarsRover'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:55:29'!
nextPointBackwardFrom: aPoint
	| nextY |
	nextY := aPoint y - 1.
	^(aPoint x)@nextY! !

!North methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:55:08'!
nextPointForwardFrom: aPoint
	| nextY |
	nextY := aPoint y + 1.
	^(aPoint x)@nextY! !

!North methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:32'!
opposite
	self subclassResponsibility ! !

!North methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:07'!
rotatedLeft90Degrees
	self subclassResponsibility ! !

!North methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:18'!
rotatedRight90Degrees
	self subclassResponsibility ! !


!classDefinition: #South category: 'MarsRover'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:13'!
nextPointBackwardFrom: aPoint
	self opposite nextPointForwardFrom: aPoint! !

!South methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:22'!
nextPointForwardFrom: aPoint
	self subclassResponsibility ! !

!South methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:32'!
opposite
	self subclassResponsibility ! !

!South methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:07'!
rotatedLeft90Degrees
	self subclassResponsibility ! !

!South methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:18'!
rotatedRight90Degrees
	self subclassResponsibility ! !


!classDefinition: #West category: 'MarsRover'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:13'!
nextPointBackwardFrom: aPoint
	self opposite nextPointForwardFrom: aPoint! !

!West methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:22'!
nextPointForwardFrom: aPoint
	self subclassResponsibility ! !

!West methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:52:33'!
opposite
	self subclassResponsibility ! !

!West methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:07'!
rotatedLeft90Degrees
	self subclassResponsibility ! !

!West methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 17:53:18'!
rotatedRight90Degrees
	self subclassResponsibility ! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'x y direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'JV 5/12/2023 17:04:50'!
direction
	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'JV 5/12/2023 17:04:43'!
position
	^x@y! !


!MarsRover methodsFor: 'converting' stamp: 'JV 5/12/2023 17:38:26'!
processCommands: commands 
	commands = '' ifTrue: [^self].
	
	direction = #North ifTrue: [
		commands = 'f' ifTrue: [y := y + 1].
		commands = 'b' ifTrue: [y := y - 1].
		commands = 'l' ifTrue: [direction := #West].
		commands = 'r' ifTrue: [direction := #East].
		^self
	].
	
	direction = #East ifTrue: [
		commands = 'f' ifTrue: [x := x + 1].
		commands = 'b' ifTrue: [x := x - 1].
		commands = 'l' ifTrue: [direction := #North].
		commands = 'r' ifTrue: [direction := #South].
		^self
		].
	
	direction = #West ifTrue: [
		commands = 'f' ifTrue: [x := x - 1].
		commands = 'b' ifTrue: [x := x + 1].
		commands = 'l' ifTrue: [direction := #South].
		commands = 'r' ifTrue: [direction := #North].
		^self
		].
	
	direction = #South ifTrue: [
		commands = 'f' ifTrue: [y := y - 1].
		commands = 'b' ifTrue: [y := y + 1].
		commands = 'l' ifTrue: [direction := #East].
		commands = 'r' ifTrue: [direction := #West].
		^self
		].
	
	
	
	! !


!MarsRover methodsFor: 'initialization' stamp: 'JV 5/12/2023 16:46:11'!
initializeWithPosition: aPosition andDirection: aDirection
	x := aPosition x.
	y := aPosition y.
	direction := aDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'JV 5/12/2023 16:44:43'!
startsOn: aPosition facing: aDirection
	^self new initializeWithPosition: aPosition andDirection: aDirection ! !
