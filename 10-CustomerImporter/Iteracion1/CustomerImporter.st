!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:18:32'!
address1Pepe

	^ Address streetName: 'San Martin' streetNumber: 3322 town: 'Olivos' province: 'BsAs' zipCode: 1636! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:18:45'!
address2Pepe

	^ Address streetName: 'Maipu' streetNumber: 888 town: 'Florida' province: 'Buenos Aires' zipCode: 1122! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:18:15'!
addressJuan

	^ Address streetName: 'Alem' streetNumber: 1122 town: 'CABA' province: 'CABA' zipCode: 1001! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:19:36'!
defaultInputStream

	^ ReadStream on: 
		'C,Pepe,Sanchez,D,22333444', String newLineString,
		'A,San Martin,3322,Olivos,1636,BsAs' , String newLineString,
		'A,Maipu,888,Florida,1122,Buenos Aires', String newLineString,
		'C,Juan,Perez,C,23-25666777-9', String newLineString,
		'A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:28:16'!
getJuanFromSession

	^ session select: [ :customer | customer firstName = 'Juan'] ofType: Customer! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:27:55'!
getPepeFromSession

	^ session select: [ :customer | customer firstName = 'Pepe'] ofType: Customer! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'fd 6/26/2023 16:35:44'!
importCustomersFrom: anInputStream
	^CustomerImporter stream: anInputStream session: session.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/22/2023 20:50:16'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/22/2023 20:50:33'!
tearDown

	session commit.
	session close! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:23:44'!
test01Importing5CustomersShows5CustomersInDBS

	

	"customerImporter := CustomerImporter stream: inputStream session: session."
	
	self importCustomersFrom: self defaultInputStream.
	
	self assert: 2 equals: (session numberOfCustomers).
	
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:24:53'!
test02ImportingCustomersShowsCorrectCustomerNames

	| juan pepe |
	self importCustomersFrom: self defaultInputStream.
	
	pepe := self getPepeFromSession anyOne.
	juan := self getJuanFromSession anyOne.
	
	self assert: (pepe lastName = 'Sanchez') & (juan lastName = 'Perez').
	
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:25:01'!
test03ImportingCustomersShowsCorrectCustomerIdentificationType

	| juan pepe |
	self importCustomersFrom: self defaultInputStream.
	
	pepe := self getPepeFromSession anyOne.
	juan := self getJuanFromSession anyOne.
	
	self assert: (pepe identificationType = 'D') & (juan identificationType = 'C').
	
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:25:09'!
test04ImportingCustomersShowsCorrectCustomerIdentificationNumber

	| juan pepe |
	self importCustomersFrom: self defaultInputStream.
	
	pepe := self getPepeFromSession anyOne.
	juan := self getJuanFromSession anyOne.
	
	self assert: (pepe identificationNumber = '22333444') & (juan identificationNumber = '23-25666777-9').
	
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:25:24'!
test05ImportingCustomersShowsCorrectCustomerAddresses

	| juan pepe |
	self importCustomersFrom: self defaultInputStream.
	
	pepe := self getPepeFromSession anyOne.	
	juan := self getJuanFromSession anyOne.
	
	self assert: (OrderedCollection with: self address1Pepe with: self address2Pepe) equals: pepe addresses.
	self assert: (OrderedCollection with: self addressJuan) equals: juan addresses.
	
	! !



!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !


!Address methodsFor: 'zip code' stamp: 'JV 6/26/2023 15:59:36'!
initializeStreetName: aStreetName streetNumber: aStreetNumber town: aTown province: aProvince zipCode: aZipCode
	streetName := aStreetName.
	streetNumber := aStreetNumber.
	town := aTown.
	province := aProvince.
	zipCode := aZipCode.! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !


!Address methodsFor: 'as yet unclassified' stamp: 'JV 6/25/2023 22:26:10'!
= anObject
	^(anObject province = province) & (anObject streetName = streetName) & (anObject streetNumber = streetNumber) & (anObject town = town) & (anObject zipCode = zipCode)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'as yet unclassified' stamp: 'JV 6/26/2023 16:02:12'!
streetName: aStreetName streetNumber: aStreetNumber town: aTown province: aProvince zipCode: aZipCode 
	^self new initializeStreetName: aStreetName streetNumber: aStreetNumber town: aTown province: aProvince zipCode: aZipCode! !


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
lastName

	^lastName ! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !


!Customer methodsFor: 'initialization' stamp: 'JV 6/26/2023 16:11:12'!
initializeFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber

	super initialize.
	addresses := OrderedCollection new.
	firstName := aFirstName.
	lastName := aLastName.
	identificationType := anIdentificationType.
	identificationNumber := anIdentificationNumber.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'importing' stamp: 'JV 6/26/2023 16:13:00'!
firstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber
	^self new initializeFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'inputStream session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'fd 6/26/2023 16:41:57'!
importCustomers
	
	| line newCustomer |
	
	line := inputStream nextLine.
	"TODO: en la primera linea nil (vacia?) deja de importar, esto esta bien? armar un test?"
	
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer 
				firstName: customerData second 
				lastName: customerData third 
				identificationType: customerData fourth 
				identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := 
				Address 
					streetName: addressData second 
					streetNumber: addressData third asNumber
					town: addressData fourth
					province: addressData sixth
					zipCode: addressData fifth asNumber.
			newCustomer addAddress: newAddress].

		line := inputStream nextLine. ].! !

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
