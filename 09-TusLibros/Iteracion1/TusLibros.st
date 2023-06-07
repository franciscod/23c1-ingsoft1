!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/7/2023 19:23:58'!
test01aNewCartIsEmpty
	| cart aBookIsbn book catalogue |
	aBookIsbn := '123456789'.
	book := Book withIsbn: aBookIsbn.
	
	catalogue := Catalogue with: (Set with: book).
	
	cart := Cart for: catalogue.
	
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/7/2023 19:24:28'!
test02aCartWithOneBookIsNotEmpty
	| cart book aBookIsbn catalogue |
	aBookIsbn := '123456789'.
	book := Book withIsbn: aBookIsbn.
	
	catalogue := Catalogue with: (Set with: book).
	
	cart := Cart for: catalogue.
	
	cart addBook: book.
	
	self deny: cart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/7/2023 19:25:05'!
test03aCartsContentIsBooksAdded
	| cart book aBookIsbn book2 aBookIsbn2 catalogue |
	
	aBookIsbn := '123456789'.
	book := Book withIsbn: aBookIsbn.

	aBookIsbn2 := '987654321'.
	book2 := Book withIsbn: aBookIsbn2.	
	
	catalogue := Catalogue with: (Set with: book with: book2).
	
	cart := Cart for: catalogue.
	
	cart addBook: book.
	cart addBook: book2.
	
	self assert: (Bag with:book with: book2) equals: cart listCart.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/7/2023 19:26:21'!
test04checkingOutCartEmptiesContent
	| cart book aBookIsbn book2 aBookIsbn2 catalogue |
	
	aBookIsbn := '123456789'.
	book := Book withIsbn: aBookIsbn.

	aBookIsbn2 := '987654321'.
	book2 := Book withIsbn: aBookIsbn2.	
	
	catalogue := Catalogue with: (Set with: book with: book2).
	
	cart := Cart for: catalogue.
	
	cart addBook: book.
	cart addBook: book2.
	
	self assert: (Bag with:book with: book2) equals: cart listCart.
	
	cart checkOut.
	
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/7/2023 19:33:10'!
test05cartsWithSameContentAddedInDifferentOrderAreTheSame
	| cart book aBookIsbn book2 aBookIsbn2 cart2 catalogue |
	
	aBookIsbn := '123456789'.
	book := Book withIsbn: aBookIsbn.

	aBookIsbn2 := '987654321'.
	book2 := Book withIsbn: aBookIsbn2.	
	
	catalogue := Catalogue with: (Set with: book with: book2).
	
	cart := Cart for: catalogue.
	cart2 := Cart for: catalogue.
		
	cart addBook: book.
	cart addBook: book2.
	
	cart2 addBook: book2.
	cart2 addBook: book.
	cart listCart.
	
	self assert: cart listCart equals: cart2 listCart.
! !

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/7/2023 19:17:41'!
test06cantAddBookToCartThatIsNotInStoresCatalogue
	| cart book aBookIsbn book2 aBookIsbn2 catalogue |
	
	aBookIsbn := '123456789'.
	book := Book withIsbn: aBookIsbn.

	aBookIsbn2 := '987654321'.
	book2 := Book withIsbn: aBookIsbn2.	
	
	catalogue := Catalogue with: (Set with: book).
	
	cart := Cart for: catalogue.
	
	cart addBook: book.
	
	self 
		should: [cart addBook: book2]
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText = 'Cant add books to cart that are not in the store catalogue'].

! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'class initialization' stamp: 'JV 6/5/2023 20:07:02'!
withIsbn: aBookIsbn
	^self new.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books id catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'JV 6/5/2023 19:55:27'!
isEmpty
	^books isEmpty.! !

!Cart methodsFor: 'accessing' stamp: 'JV 6/5/2023 20:12:34'!
listCart
	^books.! !


!Cart methodsFor: 'adding' stamp: 'JV 6/7/2023 19:20:43'!
addBook: aBook 
	(catalogue includes: aBook) ifFalse: [self error: 'Cant add books to cart that are not in the store catalogue'].
	books add: aBook.! !


!Cart methodsFor: 'checkout' stamp: 'JV 6/5/2023 20:33:35'!
checkOut
	books := OrderedCollection new.! !


!Cart methodsFor: 'initialization' stamp: 'JV 6/7/2023 19:22:00'!
initializeFor: aCatalogue 
	catalogue := aCatalogue.
	books := Bag new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'class initialization' stamp: 'JV 6/7/2023 19:21:13'!
for: aCatalogue 
	^self new initializeFor: aCatalogue.! !


!classDefinition: #Catalogue category: 'TusLibros'!
Object subclass: #Catalogue
	instanceVariableNames: 'books setOfBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogue methodsFor: 'initialization' stamp: 'JV 6/7/2023 19:18:50'!
initializeWith: aSetOfBooks 
	books := aSetOfBooks.! !


!Catalogue methodsFor: 'includes' stamp: 'JV 6/7/2023 19:23:05'!
includes: aBook 
	^books includes: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogue class' category: 'TusLibros'!
Catalogue class
	instanceVariableNames: ''!

!Catalogue class methodsFor: 'class initialization' stamp: 'JV 6/7/2023 19:21:22'!
with: aSetOfBooks
	^self new initializeWith: aSetOfBooks.! !
