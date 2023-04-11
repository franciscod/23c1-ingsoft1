!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
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

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/10/2023 21:48:39'!
assertCustomerBook: customerBook numberOfActiveCustomers: active numberOfSuspendedCustomers: suspended

	| totalCustomers |
	
	self assert: active equals: customerBook numberOfActiveCustomers.
	self assert: suspended equals: customerBook numberOfSuspendedCustomers.
	
	totalCustomers:= active + suspended.
	self assert: totalCustomers equals: customerBook numberOfCustomers.
	
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/11/2023 18:04:02'!
createCustomerBookWithCustomer: customer
	
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: customer.
	^customerBook
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/10/2023 21:25:24'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	

	| customerBook |
	
	customerBook := CustomerBook new.
	

	self testAction:  [customerBook addCustomerNamed: 'John Lennon'.] shouldNotTakeMoreThan: (50 * millisecond)
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/10/2023 21:26:58'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  

	self testAction: [customerBook removeCustomerNamed: paulMcCartney.] shouldNotTakeMoreThan: (100 *millisecond).

	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/10/2023 21:33:31'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self testAction: [customerBook addCustomerNamed: ''.] 
	shouldGiveError: Error 
	andThen: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/11/2023 18:09:09'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	
	customerBook := self createCustomerBookWithCustomer: johnLennon.	
	
	self testAction: [ customerBook removeCustomerNamed: 'Paul McCartney'.]

	 shouldGiveError:  	NotFound
	andThen: 		[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/11/2023 18:11:51'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createCustomerBookWithCustomer: paulMcCartney .	
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook numberOfActiveCustomers: 0 numberOfSuspendedCustomers: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/11/2023 18:13:01'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|

	paulMcCartney := 'Paul McCartney'.
	customerBook := self createCustomerBookWithCustomer: paulMcCartney.	
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook numberOfActiveCustomers: 0 numberOfSuspendedCustomers: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/11/2023 18:13:35'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookWithCustomer: johnLennon.	
	
	self testAction:[ customerBook suspendCustomerNamed: 'George Harrison'. ]
		shouldGiveError: CantSuspend 
		andThen: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/11/2023 18:13:58'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookWithCustomer: johnLennon.	
	customerBook suspendCustomerNamed: johnLennon.
	
	self testAction: [ customerBook suspendCustomerNamed: johnLennon.]
		shouldGiveError: CantSuspend 
		andThen: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/10/2023 21:30:52'!
testAction: anAction shouldGiveError: anError andThen: aClosure

	[ anAction value.
	self fail ]
		on: anError 
		do: aClosure! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JV 4/10/2023 21:23:51'!
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


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

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
