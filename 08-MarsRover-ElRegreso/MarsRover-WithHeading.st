!classDefinition: #LogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogTest methodsFor: 'as yet unclassified' stamp: 'JC 6/3/2023 22:47:23'!
test01MarsRoverMovesForwardAndLogsPosition
	| mr expectedLog log |
	mr := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	log remember: #Position.
	
	mr addChusma: log.
	
	mr process: 'f'.
	
	expectedLog := OrderedCollection with: 1@2.
	
	self assert: expectedLog equals: log show.! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'JC 6/3/2023 22:47:48'!
test02MarsRoverMovesForwardForwardAndLogsPosition
	| mr expectedLog log |
	mr := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	log remember: #Position.
	
	mr addChusma: log.
	
	mr process: 'ff'.
	
	expectedLog := OrderedCollection with: 1@2 with: 1@3.
	
	self assert: expectedLog equals: log show.! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'JC 6/3/2023 22:48:03'!
test03MarsRoverHeadsNorthAndLogRecordsChangeOfDirection

	| expectedLog log mr |
	mr := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	log remember: #Direction.
	
	mr addChusma: log.
	
	mr process: 'r'.
	
	expectedLog := OrderedCollection with: #East.
	
	self assert: expectedLog equals: log show.! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'JC 6/3/2023 22:48:13'!
test04MarsRoverHeadsEastThenNorthAndLogRecords2ChangesOfDirection

	| expectedLog log mr |
	mr := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	log remember: #Direction.
	
	mr addChusma: log.
	
	mr process: 'rl'.
	
	expectedLog := OrderedCollection with: #East with: #North. 
	
	self assert: expectedLog equals: log show.! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'JC 6/3/2023 22:48:26'!
test05MarsRoverProcessesFRAndLogRecordsPositionAndDirection

	| expectedLog log mr |
	mr := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	log remember: #Position.
	log remember: #Direction.
	
	mr addChusma: log.
	
	mr process: 'fr'.
	
	expectedLog := OrderedCollection with: 1@2 with: #East. 
	
	self assert: expectedLog equals: log show.! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'JC 6/3/2023 22:41:30'!
test06MarsRoverProcessesFRFThenLoggerLogsPositionAndDirectionLogs3Changes
	| mr log expectedLog |
	mr := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	log := Log new.
	log remember: #Position.
	log remember: #Direction.
	
	mr addChusma: log.
	
	expectedLog := OrderedCollection new.
	
	mr process: 'f'.
	expectedLog add: 1@2.
	self assert: expectedLog equals: (log show).
	
	
	mr process: 'r'.
	expectedLog add: #East.
	self assert: expectedLog equals: (log show).
	
	mr process: 'f'.
	expectedLog add: 2@2.
	self assert: expectedLog equals: (log show).
	
	! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #WindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #WindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowTest methodsFor: 'tests' stamp: 'JV 6/3/2023 21:42:03'!
test01MarsRoverMovesForwardThenWindowLoggingPositionShowsLastPosition
	| mr window |
	mr := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	window := Window new.
	window remember: #Position.
	
	mr addChusma: window.
	
	mr moveForward.	
	
	self assert: 1@2 equals: (window show: #Position).! !

!WindowTest methodsFor: 'tests' stamp: 'JV 6/3/2023 21:52:46'!
test02MarsRoverProcessesFRFThenWindowLoggingPositionAndDirectionShowsLastPositionAndDirection
	| mr window |
	mr := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	window := Window new.
	window remember: #Position.
	window remember: #Direction.
	
	mr addChusma: window.
	
	mr process: 'f'.
	self assert: 1@2 equals: (window show: #Position).
	self assert: nil equals: (window show: #Direction).
	
	mr process: 'r'.
	self assert: 1@2 equals: (window show: #Position).
	self assert: #East equals: (window show: #Direction).
	
	mr process: 'f'.
	self assert: 2@2 equals: (window show: #Position).
	self assert: #East equals: (window show: #Direction).
	! !


!classDefinition: #Chusma category: 'MarsRover-WithHeading'!
Object subclass: #Chusma
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Chusma methodsFor: 'remembering' stamp: 'JC 6/3/2023 23:07:01'!
remember: aProperty 
	self subclassResponsibility ! !


!Chusma methodsFor: 'adding' stamp: 'JC 6/3/2023 23:06:46'!
addValue: aValue forProperty: aProperty 
	self subclassResponsibility ! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
Chusma subclass: #Log
	instanceVariableNames: 'events properties'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'showing' stamp: 'JC 6/3/2023 22:43:06'!
initialize
	events := OrderedCollection new.
	properties := Set new.! !

!Log methodsFor: 'showing' stamp: 'JV 6/3/2023 20:47:49'!
show
	^events copy.! !


!Log methodsFor: 'adding' stamp: 'JC 6/3/2023 22:45:53'!
addValue: aValue forProperty: aProperty 
	(properties includes: aProperty) ifTrue: [events add: aValue].! !


!Log methodsFor: 'remembering' stamp: 'JC 6/3/2023 22:42:21'!
remember: aProperty 
	properties add: aProperty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Log class' category: 'MarsRover-WithHeading'!
Log class
	instanceVariableNames: ''!

!Log class methodsFor: 'class initialization' stamp: 'JV 6/3/2023 20:44:08'!
for: mr 
	self shouldBeImplemented.! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
Chusma subclass: #Window
	instanceVariableNames: 'properties'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'adding' stamp: 'JV 6/3/2023 21:44:32'!
addValue: aValue forProperty: aProperty
	properties at: aProperty put: aValue.! !


!Window methodsFor: 'showing' stamp: 'JV 6/3/2023 21:52:28'!
show: aProperty 
	^properties at: aProperty ifAbsent: [self error: 'No estaba recordando esa propiedad'].! !


!Window methodsFor: 'remember' stamp: 'JV 6/3/2023 21:41:01'!
initialize
	properties := Dictionary new.! !

!Window methodsFor: 'remember' stamp: 'JV 6/3/2023 21:40:30'!
remember: aProperty
	properties at: aProperty ifAbsentPut: nil.! !


!classDefinition: #ChusmaBox category: 'MarsRover-WithHeading'!
Object subclass: #ChusmaBox
	instanceVariableNames: 'chusmas content property'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ChusmaBox methodsFor: 'initialization' stamp: 'JC 6/3/2023 22:30:51'!
initializeFor: aChusmas withContent: anInitialContent forProperty: aProperty
	chusmas := aChusmas.
	content := anInitialContent.
	property := aProperty.! !


!ChusmaBox methodsFor: 'updates' stamp: 'JV 6/3/2023 22:07:21'!
lastUpdate
	^content.! !

!ChusmaBox methodsFor: 'updates' stamp: 'JC 6/3/2023 22:55:23'!
updateContent: aContent 
	content := aContent.
	chusmas do: [ :chusma | chusma addValue: (self valueForChusma: content) forProperty: property ].! !

!ChusmaBox methodsFor: 'updates' stamp: 'JC 6/3/2023 22:55:51'!
valueForChusma: aContent 
	^aContent! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ChusmaBox class' category: 'MarsRover-WithHeading'!
ChusmaBox class
	instanceVariableNames: ''!

!ChusmaBox class methodsFor: 'as yet unclassified' stamp: 'JC 6/3/2023 22:30:17'!
for: aChusmas withInitialContent: anInitialContent forProperty: aProperty
	^self new initializeFor: aChusmas withContent: anInitialContent forProperty: aProperty. ! !


!classDefinition: #ChusmaBoxSymbol category: 'MarsRover-WithHeading'!
ChusmaBox subclass: #ChusmaBoxSymbol
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ChusmaBoxSymbol methodsFor: 'updates' stamp: 'JC 6/3/2023 23:02:07'!
valueForChusma: aContent 
	^aContent asSymbol! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'head chusmas position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'JC 6/3/2023 23:02:18'!
initializeAt: aPosition heading: aHeadingType
	
	chusmas := OrderedCollection new.
	
	head := ChusmaBoxSymbol for: chusmas withInitialContent: (aHeadingType for: self) forProperty: #Direction.
	
	position := ChusmaBox for: chusmas withInitialContent: aPosition forProperty: #Position.! !


!MarsRover methodsFor: 'heading' stamp: 'JC 6/3/2023 22:58:10'!
headEast
	
	head updateContent: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'JC 6/3/2023 22:58:23'!
headNorth
	
	head updateContent: (MarsRoverHeadingNorth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'JC 6/3/2023 22:58:31'!
headSouth
	
	head updateContent: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'JC 6/3/2023 22:58:39'!
headWest
	
	head updateContent: (MarsRoverHeadingWest for: self). ! !

!MarsRover methodsFor: 'heading' stamp: 'JC 6/3/2023 22:58:56'!
rotateLeft
	
	head lastUpdate rotateLeft.
	
! !

!MarsRover methodsFor: 'heading' stamp: 'JC 6/3/2023 22:59:07'!
rotateRight
	
	head lastUpdate rotateRight.
	
! !


!MarsRover methodsFor: 'testing' stamp: 'JC 6/3/2023 22:59:36'!
isAt: aPosition heading: aHeadingType

	^position lastUpdate = aPosition and: [ head lastUpdate isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'JC 6/3/2023 22:59:48'!
moveBackward
	
	head lastUpdate moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'JC 6/3/2023 22:26:44'!
moveEast
	
	position updateContent: position lastUpdate + (1@0).
	! !

!MarsRover methodsFor: 'moving' stamp: 'JC 6/3/2023 23:00:02'!
moveForward
	
	head lastUpdate moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'JC 6/3/2023 22:25:59'!
moveNorth
	
	position updateContent: position lastUpdate + (0@1).
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'JC 6/3/2023 22:26:34'!
moveSouth
	
	position updateContent: position lastUpdate + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'JC 6/3/2023 22:26:38'!
moveWest
	
	position updateContent: position lastUpdate + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'addingChusmas' stamp: 'JV 6/3/2023 20:45:36'!
addChusma: unChusma 
	chusmas add: unChusma.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'symbols' stamp: 'JV 6/3/2023 21:05:28'!
asSymbol
	^#East! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'symbols' stamp: 'JV 6/3/2023 21:09:25'!
asSymbol
	^#North! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !
