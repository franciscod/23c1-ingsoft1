!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:15:37'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Numero with: (Numero with: 7) over: (Numero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:16:19'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Numero with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:29:45'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Numero with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:30:07'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Numero with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/24/2020 02:23:22'!
setUp

	zero := Numero with: 0.
	one := Numero with: 1.
	two := Numero with: 2.
	three:= Numero with: 3.
	four := Numero with: 4.
	five := Numero with: 5.
	eight := Numero with: 8.
	negativeOne := Numero with: -1.
	negativeTwo := Numero with: -2.
	
	oneHalf := Numero with: one over: two.
	oneFifth := Numero with: one over: five.
	twoFifth := Numero with: two over: five.
	twoTwentyfifth := Numero with: two over: (Numero with: 25).
	fiveHalfs := Numero with: five over: two.
	negativeOneHalf := Numero with: negativeOne over: two
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:46:17'!
* aMultiplier
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:48:28'!
+ anAdder
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:45:25'!
// aDivisor
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:44:23'!
greatestCommonDivisorWith: anEntero 
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:43:41'!
negated
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:43:29'!
printOn
	self subclassResponsibility! !


!Numero methodsFor: 'testing' stamp: 'fd 4/16/2023 19:33:00'!
isNegative
	self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'fd 4/16/2023 19:32:58'!
isOne
	self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'fd 4/16/2023 19:22:36'!
isZero
	self subclassResponsibility.! !


!Numero methodsFor: 'comparing' stamp: 'fd 4/16/2023 19:39:00'!
= anObject
	self subclassResponsibility.! !

!Numero methodsFor: 'comparing' stamp: 'fd 4/16/2023 19:34:10'!
hash
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !


!Numero class methodsFor: 'instance creation' stamp: 'fd 4/16/2023 19:55:15'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^Entero new initializeWith: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'fd 4/16/2023 19:55:29'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^Fraccion new initializeWith: numerator over: denominator! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'testing' stamp: 'fd 4/16/2023 19:33:17'!
isNegative
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'fd 4/16/2023 19:33:29'!
isOne
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'fd 4/16/2023 19:21:22'!
isZero
	^value = 0! !


!Entero methodsFor: 'initialization' stamp: 'fd 4/16/2023 19:51:38'!
initializeWith: aValue
	value := aValue! !


!Entero methodsFor: 'accessing' stamp: 'fd 4/16/2023 19:31:34'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'comparing' stamp: 'fd 4/16/2023 19:42:16'!
= anObject
	"tiene sentido ponerle otro nombre en vez de anObject?"
	^(anObject isKindOf: self class) and: [	value = anObject integerValue]! !

!Entero methodsFor: 'comparing' stamp: 'fd 4/16/2023 19:34:28'!
hash
	^value hash! !


!Entero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:47:32'!
* aMultiplier 
	(aMultiplier isKindOf: self class) ifTrue:	
		[ ^self class with: value * aMultiplier integerValue ].
		
	"aMultiplier is not like me"
	self error: 'Tipo de número no soportado'
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:48:57'!
+ anAdder 
	(anAdder isKindOf: self class) ifTrue:
		[ ^self class with: value + anAdder integerValue ].
	
	self error: 'Tipo de número no soportado'
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:45:34'!
// aDivisor 
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:44:36'!
greatestCommonDivisorWith: anEntero 
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:43:55'!
negated
	^self * (self class with: -1)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:43:09'!
printOn: aStream
	aStream print: value! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'testing' stamp: 'fd 4/16/2023 19:33:12'!
isNegative
	^denominator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'fd 4/16/2023 19:33:33'!
isOne
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'fd 4/16/2023 19:21:29'!
isZero
	 ^false! !


!Fraccion methodsFor: 'initialization' stamp: 'fd 4/16/2023 19:51:44'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'accessing' stamp: 'fd 4/16/2023 19:31:09'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'fd 4/16/2023 19:31:16'!
numerator

	^numerator! !


!Fraccion methodsFor: 'comparing' stamp: 'fd 4/16/2023 19:40:21'!
= anObject
	^ (anObject isKindOf: self class) and:
		[(numerator * anObject denominator) = 
		 (denominator * anObject numerator)]! !

!Fraccion methodsFor: 'comparing' stamp: 'fd 4/16/2023 19:34:27'!
hash
	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:48:02'!
* aMultiplier 
	(aMultiplier isKindOf: self class) ifTrue:
		[ ^self class with: (numerator * aMultiplier numerator) 
			            over: (denominator * aMultiplier denominator) ].
		
	self error: 'Tipo de número no soportado'
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:49:27'!
+ anAdder 
	(anAdder isKindOf: self class) ifTrue:
		[ | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator ].
	
	self error: 'Tipo de número no soportado'
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:45:39'!
// aDivisor 
	self error: 'Tipo de número no soportado'! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:44:47'!
greatestCommonDivisorWith: anEntero 
	self error: 'Tipo de número no soportado'! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:43:53'!
negated
	^self class with: numerator * (self class with: -1) over: denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fd 4/16/2023 19:43:08'!
printOn: aStream
	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator! !
