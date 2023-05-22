!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:51:44'!
makePortfolioWith3Accounts
	| pf anAccount anAccount2 anAccount3 |
	
	pf := Portfolio new. 
	
	anAccount := (ReceptiveAccount new) register: (Deposit for: 200). 
	anAccount2 := (ReceptiveAccount new) register: (Withdraw for: 4). 
	anAccount3 := (ReceptiveAccount new) register: (Deposit for: 90). 

	
	pf addChildEntity: anAccount; addChildEntity: anAccount2; addChildEntity: anAccount3.
	
	^pf! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/15/2023 20:25:30'!
test01NewPortfolioHasBalanceZeroAndNoTransactions
	| pf |
	pf := Portfolio new. 
	
	self assert: 0 equals: pf transactions size.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:45:50'!
test02APortfolioWithAccountsHasBalanceEqualToTheAccountsBalance
	| pf |
	pf := self makePortfolioWith3Accounts.
	
	self assert: 286 equals: pf balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:52:00'!
test03APortfolioWithPortfoliosAndAccountsHasBalanceEqualToTheSumOfBalances
	| pf account1 account2 account3 portfolio1 portfolio2 |
	
	pf := Portfolio new. 
	
	account1 := ReceptiveAccount new register: (Deposit for: 30).
	account2 := ReceptiveAccount new register: (Withdraw for: 8).
	account3 := ReceptiveAccount new register: (Deposit for: 10).

	
	portfolio1 := Portfolio new addChildEntity: account1.
	portfolio2 := Portfolio new addChildEntity: account2.
	
	pf addChildEntity: portfolio1; addChildEntity: portfolio2; addChildEntity: account3.
	
	self assert: 32 equals: pf balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:52:12'!
test04PortfolioHasRegisteredTransactionsFromAllAccountsAndPortfolios
	| pf account1 account2 portfolio1 aDeposit aWithdraw |
	
	pf := Portfolio new. 
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	aWithdraw := Withdraw register: 8 on: account1.
	aDeposit := Deposit register: 30 on: account2.
	
	portfolio1 := Portfolio new addChildEntity: account2.
	
	pf addChildEntity: portfolio1; addChildEntity: account1.
	
	self assert: (pf hasRegistered: aDeposit) & (pf hasRegistered: aWithdraw).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 15:38:07'!
test05EmptyPortfolioHasNoTransactions
	| pf emptyCollection |
	
	pf := Portfolio new.
	emptyCollection := OrderedCollection new.
	
	
	self assert: emptyCollection equals: pf transactions. 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:52:21'!
test06PortfolioWithOneAccountAndOnePortfolioHasTheirAccumulatedTransactions
	| pf account account2 pf2 |
	
	pf := Portfolio new.
	
	account := ReceptiveAccount new.
	Withdraw register: 8 on: account.
	Deposit register: 30 on: account.
	
	pf2 := Portfolio new.
	account2:= ReceptiveAccount new.
	Withdraw register: 8 on: account2.
	pf2 addChildEntity: account2.
	
	pf addChildEntity: account; addChildEntity: pf2.
	
	
	
	self assert: (account transactions union: pf2 transactions)  equals:( pf transactions asSet). 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:52:28'!
test07PortfolioWith2PortfoliosWithDifferentAccountsShouldNot
	| pf account account2 pf2 |
	
	pf := Portfolio new.
	
	account := ReceptiveAccount new.
	Withdraw register: 8 on: account.
	Deposit register: 30 on: account.
	
	pf2 := Portfolio new.
	account2:= ReceptiveAccount new.
	Withdraw register: 8 on: account2.
	pf2 addChildEntity: account2.
	
	pf addChildEntity: account; addChildEntity: pf2.
	
	
	
	self assert: (account transactions union: pf2 transactions)  equals:( pf transactions asSet). 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:52:36'!
test08PortfolioWithOneAccountHasThatAccountsTransactions
	| pf account deposit withdraw |
	
	pf := Portfolio new.
	
	account := ReceptiveAccount new.
	
	withdraw := Withdraw register: 8 on: account.
	deposit := Deposit register: 30 on: account.
	
	pf addChildEntity: account.
	
	
	self assert: account transactions equals: pf transactions. 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:53:03'!
test09PortfolioWith2PortfoliosWithDifferentAccountsShouldNotEnableToAddAccountFromOnePFToTheOther
	|  account1 account2 pf1 pf2 pf3 |
	
	pf1 := Portfolio new.
	pf2:= Portfolio new.
	pf3:= Portfolio new.
	
	account1 := ReceptiveAccount new.
	Withdraw register: 8 on: account1.

	account2 := ReceptiveAccount new.
	Deposit register: 30 on: account2.
	
	pf2 addChildEntity: account1.
	
	pf3 addChildEntity: account2.
		
	pf1 addChildEntity: pf2; addChildEntity: pf3.
	
	self 
		should: [ pf3 addChildEntity: account2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'noSePuedeAgregarUnBankEntityQueYaExisteEnElPortfolio' ].

	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'JV 5/15/2023 20:12:53'!
addToBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'JV 5/15/2023 20:13:13'!
addToBalance: aBalance

	^aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'JV 5/15/2023 20:13:32'!
addToBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'JV 5/15/2023 19:38:03'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankEntity category: 'Portfolio-Ejercicio'!
Object subclass: #BankEntity
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankEntity methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:32:02'!
ancestorPortfolios
	^ parents inject: parents into: [:ancestors :aParent |
		ancestors union: aParent ancestorPortfolios].! !

!BankEntity methodsFor: 'as yet unclassified' stamp: 'JV 5/18/2023 20:35:22'!
balance
	self subclassResponsibility ! !

!BankEntity methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:48:20'!
ensureCompatibleAncestors: aPortfolio
	| myAncestors otherAncestors |
	
	myAncestors := self ancestorPortfolios.
	otherAncestors := aPortfolio ancestorPortfolios.
	
	((myAncestors intersection: otherAncestors) size > 0) ifTrue: [self error: 'noSePuedeAgregarUnBankEntityQueYaExisteEnElPortfolio'	].
! !

!BankEntity methodsFor: 'as yet unclassified' stamp: 'JV 5/18/2023 20:35:30'!
hasRegistered: anAccount
	self subclassResponsibility ! !

!BankEntity methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:21:59'!
initialize
	parents := Set new.! !

!BankEntity methodsFor: 'as yet unclassified' stamp: 'JV 5/22/2023 16:22:34'!
registerParent: aParentPortfolio
	parents add: aParentPortfolio.! !

!BankEntity methodsFor: 'as yet unclassified' stamp: 'JV 5/18/2023 20:35:36'!
transactions
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankEntity subclass: #Portfolio
	instanceVariableNames: 'children'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'JV 5/22/2023 16:54:25'!
balance
	^children inject: 0 into: [ :accumulatedBalance :child| accumulatedBalance + child balance]
	
	
	
	
	! !

!Portfolio methodsFor: 'accessing' stamp: 'JV 5/22/2023 16:54:20'!
hasRegistered: aTransaction
	^children anySatisfy: [ :child | child hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'accessing' stamp: 'JV 5/22/2023 16:53:53'!
initialize
	super initialize.
	children := OrderedCollection new.
	! !

!Portfolio methodsFor: 'accessing' stamp: 'JV 5/22/2023 16:54:11'!
transactions
	
	^children inject: (OrderedCollection new) into: [ :transactionsAccumulated :child | transactionsAccumulated addAllLast: (child transactions); yourself]! !


!Portfolio methodsFor: 'adding' stamp: 'JV 5/22/2023 16:53:52'!
addChildEntity: aBankEntity 
	self ensureCompatibleAncestors: aBankEntity.
	
	aBankEntity registerParent: self.
	children add: aBankEntity.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JV 5/22/2023 16:21:39'!
initialize
	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'JV 5/15/2023 20:14:43'!
balance

	^transactions inject: 0 into: [ :accumulatedBalance :aTransaction | aTransaction addToBalance: accumulatedBalance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
