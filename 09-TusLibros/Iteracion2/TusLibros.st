!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JV 6/12/2023 16:19:08'!
test01CantCheckoutEmptyCart
	| card cart cashier |
	cart := CartTest new createCart.
	card := nil.
	cashier := Cashier new. 
	
	self 
		should: [cashier checkout: cart usingCatalog: StoreCatalog new withCard: card]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText = 'Cant checkout empty cart'.
			].
		! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JV 6/12/2023 16:19:27'!
test02CantCheckoutWithExpiredCard
	| cart cashier expiredCard |
	cart := CartTest new createCart.
	cart add: CartTest new itemSellByTheStore.
	expiredCard := GregorianMonthOfYear current previous: (TimeUnits month with: 1).
	cashier := Cashier new. 
	
	self 
		should: [cashier checkout: cart usingCatalog: StoreCatalog new withCard: expiredCard]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = 'Cant checkout with expired card'.
			self deny: cart isEmpty.
			].
		! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JV 6/12/2023 16:21:22'!
test03CheckingOutCartWithOneItemEmptiesCart
	| cart cashier card |
	cart := CartTest new createCart.
	cart add: CartTest new itemSellByTheStore.
	card := GregorianMonthOfYear current next: (TimeUnits month with: 1).
	cashier := Cashier new. 
	
	cashier checkout: cart usingCatalog: (StoreCatalog defaultCatalog) withCard: card.
	
	self assert: cart isEmpty.
		! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JV 6/12/2023 16:47:27'!
test04CheckingOutCartWithOneItemIncrementsFunds
	| cart cashier card book previousFunds catalog |
	cart := CartTest new createCart.
	book := CartTest new itemSellByTheStore.
	catalog := StoreCatalog defaultCatalog.
	cart add: book.
	card := GregorianMonthOfYear current next: (TimeUnits month with: 1).
	cashier := Cashier new. 
	
	previousFunds := cashier funds.
	
	cashier checkout: cart usingCatalog: catalog withCard: card.
	
	self assert: cashier funds = (previousFunds + (catalog priceFor: book)).
		! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JV 6/12/2023 16:43:47'!
test05CheckingOutCartWithMultipleItemsIncrementsFunds
	| cart cashier card book previousFunds catalog book2 |
	cart := CartTest new createCart.
	book := CartTest new itemSellByTheStore.
	book2 := 'validBook2'.
	catalog := StoreCatalog defaultCatalog.
	cart add: book.
	cart add: book2.
	
	card := GregorianMonthOfYear current next: (TimeUnits month with: 1).
	cashier := Cashier new. 
	
	previousFunds := cashier funds.
	
	cashier checkout: cart usingCatalog: catalog withCard: card.
	
	self assert: cashier funds = (previousFunds + (catalog priceFor: book)).
		! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'JV 6/12/2023 16:17:52'!
items
	^items copy.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'emptying' stamp: 'JV 6/8/2023 20:23:42'!
empty
	items removeAll.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'funds'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'JV 6/12/2023 16:42:34'!
checkout: aCart usingCatalog: aCatalog withCard: aCard 
	aCart isEmpty ifTrue: [self error: 'Cant checkout empty cart'].
	
	aCard < GregorianMonthOfYear current ifTrue: [self error: 'Cant checkout with expired card'.].
	""
	funds := (aCart items) inject: funds into: [ :accumulatedFunds :item | accumulatedFunds + (aCatalog priceFor: item)].
	
	aCart empty.! !


!Cashier methodsFor: 'funds' stamp: 'JV 6/12/2023 15:54:47'!
funds
	^funds.! !

!Cashier methodsFor: 'funds' stamp: 'JV 6/12/2023 15:56:41'!
initialize
	funds := 0. ! !


!classDefinition: #StoreCatalog category: 'TusLibros'!
Object subclass: #StoreCatalog
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreCatalog methodsFor: 'initialization' stamp: 'JV 6/12/2023 16:44:25'!
initializeDefaultCatalog
	items := Dictionary new. 
	items at: 'validBook' put: 50.
	items at: 'validBook2' put: 20.! !


!StoreCatalog methodsFor: 'pricing' stamp: 'JV 6/12/2023 16:39:55'!
priceFor: aBook 
	^items at: aBook asSymbol ifAbsent: [ self error: 'El libro no esta en el catalogo'].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreCatalog class' category: 'TusLibros'!
StoreCatalog class
	instanceVariableNames: ''!

!StoreCatalog class methodsFor: 'class initialization' stamp: 'JV 6/12/2023 16:00:27'!
defaultCatalog
	^self new initializeDefaultCatalog! !
