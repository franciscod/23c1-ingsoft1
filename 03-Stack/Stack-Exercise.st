!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fd 4/23/2023 10:59:00'!
assertThatStack: aStack hasEqualElements: anotherStack
	self deny: (aStack isEmpty xor: anotherStack isEmpty). "only one empty"
	(aStack isEmpty and: anotherStack isEmpty) ifTrue: [^true].  "both empty"
	
	self assert: aStack top equals: anotherStack top.
	aStack pop. anotherStack pop.
	self assertThatStack: aStack hasEqualElements: anotherStack! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fd 4/23/2023 10:31:41'!
test01findWithWintPrefix
	| stack response |
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	response := SentenceFinderByPrefix new findSentenceContainingPrefix: 'Wint' inOOStack: stack.
	
	self assert: response size = 1.
	self assert: (response at: 1) = 'Winter is here'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fd 4/23/2023 10:39:40'!
test02findWithThePrefix
	| stack response |
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	response := SentenceFinderByPrefix new findSentenceContainingPrefix: 'The' inOOStack: stack.
	
	self assert: response size = 1.
	self assert: (response at: 1) = 'The winds of Winter'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'fd 4/23/2023 10:54:16'!
test03afterFindStackRemainsTheSame
	| stack stackAux |
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	stackAux := OOStack new.
	stackAux push: 'winter is coming'.
	stackAux push: 'winning is everything'.
	stackAux push: 'The winds of Winter'.
	stackAux push: 'Winter is here'.
	
	SentenceFinderByPrefix new findSentenceContainingPrefix: 'The' inOOStack: stack.
	
	self assertThatStack: stack hasEqualElements: stackAux.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initializing' stamp: 'fd 4/20/2023 21:23:35'!
initialize
	contents  := OOStackContentsEmpty new.! !


!OOStack methodsFor: 'testing' stamp: 'fd 4/20/2023 21:22:52'!
isEmpty
	^ contents isEmpty! !

!OOStack methodsFor: 'testing' stamp: 'fd 4/20/2023 21:24:35'!
size
	^contents size ! !

!OOStack methodsFor: 'testing' stamp: 'fd 4/20/2023 21:24:22'!
top
	^contents top.! !


!OOStack methodsFor: 'updating' stamp: 'fd 4/20/2023 21:25:49'!
pop
	| val |
	val := contents top.
	contents := contents withoutTop.
	^val! !

!OOStack methodsFor: 'updating' stamp: 'fd 4/20/2023 21:31:22'!
push: anElement 
	contents := OOStackContentsSomething new with: anElement onTopOf: contents! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackContents category: 'Stack-Exercise'!
Object subclass: #OOStackContents
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackContents methodsFor: 'testing' stamp: 'fd 4/20/2023 21:27:23'!
isEmpty
	self subclassResponsibility.! !

!OOStackContents methodsFor: 'testing' stamp: 'fd 4/20/2023 21:35:22'!
size
	self subclassResponsibility.! !

!OOStackContents methodsFor: 'testing' stamp: 'fd 4/20/2023 21:35:23'!
top
	self subclassResponsibility.! !

!OOStackContents methodsFor: 'testing' stamp: 'fd 4/20/2023 21:35:25'!
withoutTop
	self subclassResponsibility.! !


!classDefinition: #OOStackContentsEmpty category: 'Stack-Exercise'!
OOStackContents subclass: #OOStackContentsEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackContentsEmpty methodsFor: 'testing' stamp: 'fd 4/20/2023 21:27:49'!
isEmpty
	^ true! !

!OOStackContentsEmpty methodsFor: 'testing' stamp: 'fd 4/20/2023 21:32:47'!
size
	^0! !

!OOStackContentsEmpty methodsFor: 'testing' stamp: 'fd 4/20/2023 21:33:37'!
top
	self error: OOStack stackEmptyErrorDescription ! !

!OOStackContentsEmpty methodsFor: 'testing' stamp: 'fd 4/20/2023 21:36:55'!
withoutTop
	self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackContentsSomething category: 'Stack-Exercise'!
OOStackContents subclass: #OOStackContentsSomething
	instanceVariableNames: 'top rest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackContentsSomething methodsFor: 'initializing' stamp: 'fd 4/20/2023 21:30:55'!
with: anElement onTopOf: otherContents
	top := anElement.
	rest := otherContents
! !


!OOStackContentsSomething methodsFor: 'testing' stamp: 'fd 4/20/2023 21:27:56'!
isEmpty
	^ false! !

!OOStackContentsSomething methodsFor: 'testing' stamp: 'fd 4/20/2023 21:32:58'!
size
	^ 1 + rest size! !

!OOStackContentsSomething methodsFor: 'testing' stamp: 'fd 4/20/2023 21:31:52'!
top
	^top! !

!OOStackContentsSomething methodsFor: 'testing' stamp: 'fd 4/20/2023 21:32:11'!
withoutTop
	^rest.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'fd 4/23/2023 10:57:31'!
findSentenceContainingPrefix: aPrefixToFind inOOStack: aOOStack

	| aux item sentencesFound |
	
	sentencesFound := OrderedCollection new.
	aux := OOStack new.

	[aOOStack isEmpty] whileFalse: 	[
		item := aOOStack pop.
		(item beginsWith: aPrefixToFind) ifTrue: [sentencesFound add: item].
		aux push: item.
	].

	"restore original contents"
	[aux isEmpty] whileFalse: 	[	aOOStack push: aux pop].
	
	^ sentencesFound! !
