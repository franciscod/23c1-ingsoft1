!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:28:16'!
getJuanFromSession

	^ session select: [ :customer | customer firstName = 'Juan'] ofType: Customer! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:27:55'!
getPepeFromSession

	^ session select: [ :customer | customer firstName = 'Pepe'] ofType: Customer! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 23:17:10'!
importCustomers

	| inputStream  newCustomer line |
	
	inputStream := ReadStream on: 	
		'C,Pepe,Sanchez,D,22333444', String newLineString,
		'A,San Martin,3322,Olivos,1636,BsAs' , String newLineString,
		'A,Maipu,888,Florida,1122,Buenos Aires', String newLineString,
		'C,Juan,Perez,C,23-25666777-9', String newLineString,
		'A,Alem,1122,CABA,1001,CABA'.

	"inputStream := UniFileStream new open: 'input.txt' forWrite: false."

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].


	inputStream close.
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:22:43'!
juanAddress

	^ Address new streetName: 'Alem'; streetNumber: 1122;province: 'CABA'; town: 'CABA'; zipCode: 1001! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/22/2023 20:52:52'!
numberOfCustomers
	^5.
	
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:22:26'!
pepeAddress1

	^ Address new streetName: 'San Martin'; streetNumber: 3322;province: 'BsAs'; town: 'Olivos'; zipCode: 1636! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:22:34'!
pepeAddress2

	^ Address new streetName: 'Maipu'; streetNumber: 888;province: 'Buenos Aires'; town: 'Florida'; zipCode: 1122! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/22/2023 20:50:16'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/22/2023 20:50:33'!
tearDown

	session commit.
	session close! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 23:43:55'!
test01Importing5CustomersShows5CustomersInDBS

	| customerImporter inputStream |
	
	inputStream :=	 ReadStream on: 
		'C,Pepe,Sanchez,D,22333444', String newLineString,
		'A,San Martin,3322,Olivos,1636,BsAs' , String newLineString,
		'A,Maipu,888,Florida,1122,Buenos Aires', String newLineString,
		'C,Juan,Perez,C,23-25666777-9', String newLineString,
		'A,Alem,1122,CABA,1001,CABA'.

	customerImporter := CustomerImporter stream: inputStream session: session.
	
	self assert: 2 equals: (customerImporter numberOfCustomers).
	
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:38:46'!
test02ImportingCustomersShowsCorrectCustomerNames

	| juan pepe |
	self importCustomers.
	
	pepe := self getPepeFromSession anyOne.
	juan := self getJuanFromSession anyOne.
	
	self assert: (pepe lastName = 'Sanchez') & (juan lastName = 'Perez').
	
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:38:58'!
test03ImportingCustomersShowsCorrectCustomerIdentificationType

	| juan pepe |
	self importCustomers.
	
	pepe := self getPepeFromSession anyOne.
	juan := self getJuanFromSession anyOne.
	
	self assert: (pepe identificationType = 'D') & (juan identificationType = 'C').
	
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:39:10'!
test04ImportingCustomersShowsCorrectCustomerIdentificationNumber

	| juan pepe |
	self importCustomers.
	
	pepe := self getPepeFromSession anyOne.
	juan := self getJuanFromSession anyOne.
	
	self assert: (pepe identificationNumber = '22333444') & (juan identificationNumber = '23-25666777-9').
	
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:44:24'!
test05ImportingCustomersShowsCorrectCustomerAddresses

	| juan pepe |
	self importCustomers.
	
	pepe := self getPepeFromSession anyOne.	
	juan := self getJuanFromSession anyOne.
	
	self assert: (OrderedCollection with: self pepeAddress1 with: self pepeAddress2) equals: pepe addresses.
	self assert: (OrderedCollection with: self juanAddress) equals: juan addresses.
	
	! !


!ImportTest methodsFor: 'testing' stamp: 'JV 6/25/2023 22:37:51'!
namesAreCorrect
	^(session selectAllOfType: Customer) inject: true into: [ :namesAreCorrect :customer | 
		namesAreCorrect and customer] ! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:26:10'!
= anObject
	^(anObject province = province) & (anObject streetName = streetName) & (anObject streetNumber = streetNumber) & (anObject town = town) & (anObject zipCode = zipCode)! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'JV 6/22/2023 21:25:06'!
= anObject
	^(self firstName = anObject firstName) & (self lastName = anObject lastName) & (self identificationNumber = anObject identificationNumber) & (self identificationType = anObject identificationType)! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'JV 6/25/2023 22:44:32'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !



!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'inputStream session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'JV 6/25/2023 23:45:36'!
importCustomers
	
	| line |
	
	line := inputStream nextLine.
	
	[ line notNil ] whileTrue: [ | newCustomer |
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].


	inputStream close.! !

!CustomerImporter methodsFor: 'initialization' stamp: 'JV 6/25/2023 23:43:11'!
initializeWithStream: anInputStream session: aSession 
	
	
	inputStream := anInputStream.
	session := aSession.
	
	self importCustomers.! !


!CustomerImporter methodsFor: 'accessing' stamp: 'JV 6/25/2023 23:22:14'!
numberOfCustomers
	^session numberOfCustomers.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'class initialization' stamp: 'JV 6/25/2023 23:18:25'!
stream: anInputStream session: aSession 
	^self new initializeWithStream: anInputStream session: aSession ! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'JV 6/22/2023 21:04:07'!
numberOfCustomers
	^(self selectAllOfType: Customer) size.! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !


!DataBaseSession methodsFor: 'accessing' stamp: 'JV 6/22/2023 21:49:36'!
customerWithId: aCustomerId
	self halt.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
