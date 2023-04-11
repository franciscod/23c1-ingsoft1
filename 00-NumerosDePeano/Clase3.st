!classDefinition: #I category: 'Clase3'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Clase3'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 20:34:17'!
* aNumber
	^ aNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 3/27/2023 21:02:36'!
+ aNaturalNumber
	^ aNaturalNumber next! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 21:04:43'!
- aNaturalNumber
	^ self error: self negativeNumbersNotSupportedErrorDescription ! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 21:04:09'!
/ aNumber
	aNumber == I ifTrue:[^I].
	self error: self canNotDivideByBiggerNumberErrorDescription.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 21:02:58'!
canNotDivideByBiggerNumberErrorDescription
	^'Dividir por numeros mas grandes no soportado'! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 20:33:14'!
negativeNumbersNotSupportedErrorDescription
	^'Numeros negativos no soportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 3/27/2023 21:02:23'!
next
	^ II! !

!I class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 20:26:14'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'FD 3/30/2023 21:44:26'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.! !


!classDefinition: #II category: 'Clase3'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Clase3'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 20:36:26'!
* aNumber
	^self previous * aNumber + aNumber! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 20:24:40'!
+ aNaturalNumber
	^ previous + aNaturalNumber next! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/27/2023 21:55:41'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 21:25:35'!
/ aNumber
	"5 / 2 --> 1 vez ok
	3 / 2  --> 2 veces ok
	1 / 2 --> error
	"
	|nonNegativeAfterSubtract nextDiv|
	aNumber == self ifTrue: [^I].
	[nonNegativeAfterSubtract := self - aNumber] on: Error do: [^self error: self canNotDivideByBiggerNumberErrorDescription].
	[nextDiv := nonNegativeAfterSubtract / aNumber] on: Error do: [^I].
	
	^ I + nextDiv.! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 21:18:16'!
canNotDivideByBiggerNumberErrorDescription
	^'Dividir por numeros mas grandes no soportado'! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/27/2023 21:49:48'!
clean
	next ifNotNil: [next clean. next removeFromSystem].
	next := nil! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 21:16:42'!
many
	|n|
	n := II.
	n := n + n.! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 21:43:23'!
next
	^ next ifNil: [next := II createChildNamed: self name , #I :: previous: previous next].
! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 20:24:17'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 20:24:26'!
previous: aNaturalNumber
	previous := aNaturalNumber! !

!II class methodsFor: 'as yet unclassified' stamp: 'FD 3/30/2023 20:25:01'!
subtractFrom: aNaturalNumber
	^ previous subtractFrom: aNaturalNumber previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'FD 3/30/2023 21:44:26'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Clase3'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Clase3'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'FD 3/30/2023 21:44:26'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Clase3'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Clase3'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'FD 3/30/2023 21:44:26'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Clase3'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Clase3'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'FD 3/30/2023 21:44:26'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Clase3'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Clase3'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'FD 3/30/2023 21:44:26'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!