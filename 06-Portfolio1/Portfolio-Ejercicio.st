!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/15/2023 20:25:30'!
test01NewPortfolioHasBalanceZeroAndNoTransactions
	| pf |
	pf := Portfolio new. 
	
	self assert: 0 equals: pf transactions size.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/15/2023 21:00:19'!
test02APortfolioWithAccountsHasBalanceEqualToTheAccountsBalance
	| pf anAccount anAccount2 anAccount3 |
	
	pf := Portfolio new. 
	
	anAccount := (ReceptiveAccount new) register: (Deposit for: 200). 
	anAccount2 := (ReceptiveAccount new) register: (Withdraw for: 4). 
	anAccount3 := (ReceptiveAccount new) register: (Deposit for: 90). 

	
	pf addAccount: anAccount; addAccount: anAccount2; addAccount: anAccount3.
	
	self assert: 286 equals: pf balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/15/2023 21:10:41'!
test03APortfolioWithPortfoliosAndAccountsHasBalanceEqualToTheSumOfBalances
	| pf account1 account2 account3 portfolio1 portfolio2 |
	
	pf := Portfolio new. 
	
	account1 := ReceptiveAccount new register: (Deposit for: 30).
	account2 := ReceptiveAccount new register: (Withdraw for: 8).
	account3 := ReceptiveAccount new register: (Deposit for: 10).

	
	portfolio1 := Portfolio new addAccount: account1.
	portfolio2 := Portfolio new addAccount: account2.
	
	pf addPortfolio: portfolio1; addPortfolio: portfolio2; addAccount: account3.
	
	self assert: 32 equals: pf balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JV 5/15/2023 21:34:59'!
test04PortfolioHasRegisteredTransactionsFromAllAccountsAndPortfolios
	| pf account1 account2 portfolio1 aDeposit aWithdraw |
	
	pf := Portfolio new. 
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	aWithdraw := Withdraw register: 8 on: account1.
	aDeposit := Deposit register: 30 on: account2.
	
	portfolio1 := Portfolio new addAccount: account2.
	
	pf addPortfolio: portfolio1; addAccount: account1.
	
	self assert: (pf hasRegistered: aDeposit) & (pf hasRegistered: aWithdraw).! !


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


!classDefinition: #Bank category: 'Portfolio-Ejercicio'!
Object subclass: #Bank
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Bank methodsFor: 'as yet unclassified' stamp: 'JV 5/18/2023 20:35:22'!
balance
	self subclassResponsibility ! !

!Bank methodsFor: 'as yet unclassified' stamp: 'JV 5/18/2023 20:35:30'!
hasRegistered: anAccount
	self subclassResponsibility ! !

!Bank methodsFor: 'as yet unclassified' stamp: 'JV 5/18/2023 20:35:36'!
transactions
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Bank subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'JV 5/18/2023 20:43:39'!
balance
	^accountsAndPortfolios inject: 0 into: [ :accumulatedBalance :accountOrPortfolio| accumulatedBalance + accountOrPortfolio balance]
	
	
	
	
	! !

!Portfolio methodsFor: 'accessing' stamp: 'JV 5/18/2023 20:44:07'!
hasRegistered: aTransaction
	^accountsAndPortfolios anySatisfy: [ :accountOrPortfolio | accountOrPortfolio hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'accessing' stamp: 'JV 5/18/2023 20:51:07'!
initialize
	accountsAndPortfolios := OrderedCollection new.
	! !

!Portfolio methodsFor: 'accessing' stamp: 'JV 5/15/2023 20:30:19'!
transactions
	^OrderedCollection new.! !


!Portfolio methodsFor: 'adding' stamp: 'JV 5/18/2023 20:42:38'!
addAccount: anAccount 
	accountsAndPortfolios add: anAccount.! !

!Portfolio methodsFor: 'adding' stamp: 'JV 5/18/2023 20:51:18'!
addPortfolio: aPortfolio 
	accountsAndPortfolios add: aPortfolio.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Bank subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

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
