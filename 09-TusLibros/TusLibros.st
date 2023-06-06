!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/5/2023 20:13:18'!
test01aNewCartIsEmpty
	| cart |
	cart := Cart new.
	
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/5/2023 20:13:34'!
test02aCartWithOneBookIsNotEmpty
	| cart book aBookIsbn |
	cart := Cart new.
	
	aBookIsbn := '123456789'.
	book := Book withIsbn: aBookIsbn.
	
	cart addBook: book.
	
	self deny: cart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/5/2023 20:13:53'!
test03aCartsContentIsBooksAdded
	| cart book aBookIsbn book2 aBookIsbn2 |
	
	cart := Cart new.
	
	aBookIsbn := '123456789'.
	book := Book withIsbn: aBookIsbn.

	aBookIsbn2 := '987654321'.
	book2 := Book withIsbn: aBookIsbn2.	
	
	cart addBook: book.
	cart addBook: book2.
	
	self assert: (OrderedCollection with:book with: book2) equals: cart listCart.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'JV 6/5/2023 20:33:13'!
test04checkingOutCartEmptiesContent
	| cart book aBookIsbn book2 aBookIsbn2 |
	
	cart := Cart new.
	
	aBookIsbn := '123456789'.
	book := Book withIsbn: aBookIsbn.

	aBookIsbn2 := '987654321'.
	book2 := Book withIsbn: aBookIsbn2.	
	
	cart addBook: book.
	cart addBook: book2.
	
	self assert: (OrderedCollection with:book with: book2) equals: cart listCart.
	
	cart checkOut.
	
	self assert: cart isEmpty.! !


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
	instanceVariableNames: 'books id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'JV 6/5/2023 20:06:20'!
initialize
	books := OrderedCollection new.
	! !

!Cart methodsFor: 'accessing' stamp: 'JV 6/5/2023 19:55:27'!
isEmpty
	^books isEmpty.! !

!Cart methodsFor: 'accessing' stamp: 'JV 6/5/2023 20:12:34'!
listCart
	^books.! !


!Cart methodsFor: 'adding' stamp: 'JV 6/5/2023 19:40:49'!
addBook: aBook 
	books add: aBook.! !


!Cart methodsFor: 'checkout' stamp: 'JV 6/5/2023 20:33:35'!
checkOut
	books := OrderedCollection new.! !
