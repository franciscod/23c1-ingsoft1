!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'customerSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'JV 7/3/2023 15:45:41'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: customerSystem session.
	
	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly

	! !

!ImportTest methodsFor: 'tests' stamp: 'JV 7/2/2023 22:58:10'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: customerSystem session. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:03'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:36'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:51:14'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 20:01:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'JV 6/29/2023 20:44:54'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: ( customerSystem numberOfCustomers).
	importedCustomer := self customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportTest methodsFor: 'assertions' stamp: 'JV 6/29/2023 20:44:54'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: ( customerSystem numberOfCustomers)! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'JV 6/29/2023 20:48:37'!
assertNoCustomerWasImported

	^ self assert: 0 equals: (customerSystem numberOfCustomers)! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'JV 7/2/2023 23:03:05'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: customerSystem session. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'JV 7/3/2023 15:40:22'!
setUp
	
	customerSystem := Environment newCustomerSystem.
	customerSystem start.
	
	
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'JV 6/29/2023 20:58:22'!
tearDown

	customerSystem stop.
	! !


!ImportTest methodsFor: 'customer' stamp: 'JV 7/2/2023 23:02:38'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (customerSystem session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 19:38:32'!
isAddressesEmpty

	^addresses isEmpty ! !


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


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream newCustomer line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'HAW 5/22/2022 18:48:58'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:59:39'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:59:39'!
importCustomer

	self assertValidCustomerRecord.

	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:23:55'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:58:41'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class canNotImportAddressWithoutCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
importAddress

	| newAddress |

	self assertCustomerWasImported.
	self assertValidAddressRecord.

	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:37:45'!
isAddressRecord

	^ record first = 'A'! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 20:04:35'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 18:47:26'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 18:49:33'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 20:04:06'!
importRecord

	self assertRecordNotEmpty.

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].

	self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:13:48'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:41:39'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:53:56'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:24:11'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 20:49:18'!
numberOfCustomers
	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 20:51:37'!
session
	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 20:50:43'!
start
	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 21:00:02'!
stop
	self subclassResponsibility ! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 21:32:53'!
initialize

	session := DataBaseSession for: (Array with: Address with: Customer). ! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 20:31:03'!
numberOfCustomers

	^ (session selectAllOfType: Customer) size! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 20:37:55'!
session
	^session! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 20:50:08'!
start
	session beginTransaction.! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 20:58:34'!
stop 
	session commit.
	session close.! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 7/2/2023 22:53:03'!
initialize
	session := DataBaseLocalSession for: (Array with: Address with: Customer).! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 7/2/2023 22:53:32'!
numberOfCustomers
	^ (session selectAllOfType: Customer) size! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 20:52:19'!
start! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 21:00:19'!
stop! !


!TransientCustomerSystem methodsFor: 'session' stamp: 'JV 7/2/2023 22:46:59'!
session
	^session! !


!classDefinition: #DataBaseLocalSession category: 'CustomerImporter'!
Object subclass: #DataBaseLocalSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseLocalSession methodsFor: 'transaction management' stamp: 'JV 7/2/2023 22:52:44'!
beginTransaction

	! !

!DataBaseLocalSession methodsFor: 'transaction management' stamp: 'JV 7/2/2023 22:52:44'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseLocalSession methodsFor: 'closing' stamp: 'JV 7/2/2023 22:52:44'!
close

	! !


!DataBaseLocalSession methodsFor: 'persistence - private' stamp: 'JV 7/2/2023 22:52:45'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseLocalSession methodsFor: 'persistence - private' stamp: 'JV 7/2/2023 22:52:45'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseLocalSession methodsFor: 'persistence - private' stamp: 'JV 7/2/2023 22:52:45'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseLocalSession methodsFor: 'initialization' stamp: 'JV 7/2/2023 22:52:45'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseLocalSession methodsFor: 'id' stamp: 'JV 7/2/2023 22:52:45'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseLocalSession methodsFor: 'persistance' stamp: 'JV 7/2/2023 22:53:51'!
persist: anObject

	| table |

	
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseLocalSession methodsFor: 'selecting' stamp: 'JV 7/2/2023 22:53:54'!
select: aCondition ofType: aType

	
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseLocalSession methodsFor: 'selecting' stamp: 'JV 7/2/2023 22:53:57'!
selectAllOfType: aType

	
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseLocalSession class' category: 'CustomerImporter'!
DataBaseLocalSession class
	instanceVariableNames: ''!

!DataBaseLocalSession class methodsFor: 'instance creation' stamp: 'JV 7/2/2023 22:52:45'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


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


!DataBaseSession methodsFor: 'persistance' stamp: 'JV 7/3/2023 15:45:01'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'JV 7/3/2023 15:45:18'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'JV 7/3/2023 15:45:28'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 21:29:09'!
current

	^(self subclasses detect: [ :subclass | subclass isCurrent]).! !

!Environment class methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 21:35:34'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 21:37:40'!
newCustomerSystem
	^(self subclasses detect: [ :env | env isCurrent]) newCustomerSystem.! !


!classDefinition: #DevelopingEnvironment category: 'CustomerImporter'!
Environment subclass: #DevelopingEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopingEnvironment class' category: 'CustomerImporter'!
DevelopingEnvironment class
	instanceVariableNames: ''!

!DevelopingEnvironment class methodsFor: 'as yet unclassified' stamp: 'JV 7/3/2023 15:46:06'!
isCurrent
	^true! !

!DevelopingEnvironment class methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 21:37:40'!
newCustomerSystem
	^TransientCustomerSystem new.! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'as yet unclassified' stamp: 'JV 7/3/2023 15:46:13'!
isCurrent
	^false! !

!IntegrationEnvironment class methodsFor: 'as yet unclassified' stamp: 'JV 6/29/2023 21:37:40'!
newCustomerSystem
	^PersistentCustomerSystem new.! !
