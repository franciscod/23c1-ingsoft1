!classDefinition: #AlreadyExists category: 'CodigoRepetido-Ejercicio'!
Error subclass: #AlreadyExists
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NameCannotBeEmpty category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NameCannotBeEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:15:19'!
assertCustomerBook: customerBook numberOfActiveCustomers: active numberOfSuspendedCustomers: suspended

	| totalCustomers |
	
	self assert: active equals: customerBook numberOfActiveCustomers.
	self assert: suspended equals: customerBook numberOfSuspendedCustomers.
	
	totalCustomers := active + suspended.
	self assert: totalCustomers equals: customerBook numberOfCustomers.
	
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:10:18'!
createCustomerBookWithCustomer: customer
	
	^CustomerBook new :: addCustomerNamed: customer.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:09:36'!
createCustomerBookWithSuspendedCustomer: customer

	^self createCustomerBookWithCustomer: customer :: suspendCustomerNamed: customer.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:11:05'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	
	customerBook := CustomerBook new.
	
	self testAction: [customerBook addCustomerNamed: 'John Lennon'.] 
		shouldNotTakeMoreThan: (50 * millisecond)
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:11:13'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createCustomerBookWithCustomer: paulMcCartney.
	
	self testAction: [customerBook removeCustomerNamed: paulMcCartney.]
		shouldNotTakeMoreThan: (100 * millisecond).

	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:12:44'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
	
	
	customerBook := CustomerBook new.
	
	self testAction: [customerBook addCustomerNamed: ''.]
		shouldGiveError: NameCannotBeEmpty 
		andThen: [:anError | 
			self assert: customerBook isEmpty ]

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:12:33'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookWithCustomer: johnLennon.	
	
	self testAction: [customerBook removeCustomerNamed: 'Paul McCartney'.]
		shouldGiveError: NotFound
		andThen: [:anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:13:36'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createCustomerBookWithSuspendedCustomer: paulMcCartney.	
	
	
	self assertCustomerBook: customerBook 
		numberOfActiveCustomers: 0
		numberOfSuspendedCustomers: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:13:33'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|

	paulMcCartney := 'Paul McCartney'.
	customerBook := self createCustomerBookWithSuspendedCustomer: paulMcCartney.	
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook
		numberOfActiveCustomers: 0
		numberOfSuspendedCustomers: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:14:14'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookWithCustomer: johnLennon.	
	
	self testAction: [ customerBook suspendCustomerNamed: 'George Harrison'. ]
		shouldGiveError: CantSuspend 
		andThen: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 16:52:31'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookWithSuspendedCustomer: johnLennon.	
	
	self testAction: [ customerBook suspendCustomerNamed: johnLennon.]
		shouldGiveError: CantSuspend 
		andThen: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:14:28'!
test09CanNotAddAnExistingCustomer

	| customerBook ringoStarr |
	
	ringoStarr := 'Richard Starkey'.
	customerBook := self createCustomerBookWithCustomer: ringoStarr.
	
	self testAction: [ customerBook addCustomerNamed: ringoStarr. ] 
		shouldGiveError: AlreadyExists 
		andThen: [ :anError | 
			self assertCustomerBook: customerBook 
				numberOfActiveCustomers: 1 
				numberOfSuspendedCustomers: 0 ]

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:15:06'!
testAction: anAction shouldGiveError: anError andThen: aClosure

	[ anAction value. self fail ]
		on: anError 
		do: aClosure! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FD 4/12/2023 17:14:50'!
testAction: anAction shouldNotTakeMoreThan: anInterval

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anAction value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (anInterval)! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'FD 4/12/2023 17:04:49'!
addCustomerNamed: aName

	aName isEmpty
		ifTrue: [ ^NameCannotBeEmpty signal ].
	self includesCustomerNamed: aName ::
		ifTrue: [ ^AlreadyExists signal ].

	active add: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FD 4/12/2023 16:55:55'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FD 4/12/2023 16:59:57'!
removeCustomerNamed: aName 
 
	active remove: aName 
		ifAbsent: [suspended remove: aName 
			ifAbsent: [^NotFound signal.]].
	^aName.

! !

!CustomerBook methodsFor: 'customer management' stamp: 'FD 4/12/2023 17:00:26'!
suspendCustomerNamed: aName 

	active remove: aName 
		ifAbsent: [^CantSuspend signal.].
	
	suspended add: aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
