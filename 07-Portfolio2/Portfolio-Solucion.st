!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:13:57'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:13:49'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:13:40'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:13:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:13:23'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:13:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:13:06'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:12:57'!
test08transferring10FromOneAccountToAnotherModifiesBalanceBy10

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer for: 10 from: account1 to: account2.
		
	self assert: (account1 balance = -10) & (account2 balance = 10).! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:12:25'!
test09transferring10FromOneAccountToAnotherModifiesBalanceBy10

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer for: 10 from: account1 to: account2.
		
	self assert: (account1 balance = -10) & (account2 balance = 10).! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:12:17'!
test10transferringANonPositiveAmountGivesError

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	
		
	self should: [ Transfer for: -10 from: account1 to: account2. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'TransferForNonPositiveAmountIsNotAllowed' ].! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:09:48'!
test11transferring10FromOneAccountToAnotherRegistersTransactionsInBothAccounts

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	transfer := Transfer for: 10 from: account1 to: account2.
		
	self assert: (account1 hasRegistered: (transfer outgoingEnd)) & (account2 hasRegistered: transfer incomingEnd).! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 21:11:59'!
test12transferringToSameAccountGivesError

	| account1 |
	
	account1 := ReceptiveAccount new.

	self
		should: [ Transfer for: 10 from: account1 to: account1.]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = 'CannotTransferToOwnAccount'].! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'fd 5/29/2023 21:47:20'!
test13reportOfEmptyAccountOutputsOnlyBalance0

	| account1 result report |
	
	account1 := ReceptiveAccount new.
	
	report := AccountSummaryReport for: account1.
	result := report process.
	
	self assert: result equals: 'Balance = 0'! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'fd 5/29/2023 21:54:58'!
test14reportOfEmptyPortfolioOutputsOnlyBalance0

	| pf result report |
	pf := Portfolio new.
	
	report := AccountSummaryReport for: pf.
	result := report process.
	
	self assert: result equals: 'Balance = 0'! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'fd 5/29/2023 21:55:14'!
test15reportOfAccountOutputsItsTransactionsTransferencesAndBalance

	| account1 account2 result report |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 70 on: account1.
	Withdraw register: 30 on: account1 .
	Transfer for: 5 from: account1 to: account2.
	Transfer for: 50 from: account2 to: account1 .
	
	
	report := AccountSummaryReport for: account1.
	result := report process.
	
	self assert: result equals: ('Depósito por 70.', String newLineString,
	'Extracción por 30.', String newLineString,
	'Salida por transferencia de 5.', String newLineString,
	'Entrada por transferencia de 50.', String newLineString,
	'Balance = 85')! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'fd 5/29/2023 22:00:39'!
test16reportOfPortfolioOutputsAllAccountsTransactionsTransferencesAndBalance

	| account1 account2 portfolio report result |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	portfolio add: account1.
	portfolio add: account2.
	
	Deposit register: 70 on: account1.
	Withdraw register: 30 on: account2.
	Transfer for: 5 from: account1 to: account2.
	Transfer for: 50 from: account2 to: account1.
	
	report := AccountSummaryReport for: portfolio.
	result := report process.
	
	self assert: result equals: ('Depósito por 70.', String newLineString,
	'Salida por transferencia de 5.', String newLineString,
	'Entrada por transferencia de 50.', String newLineString,
	'Extracción por 30.', String newLineString,
	'Entrada por transferencia de 5.', String newLineString,
	'Salida por transferencia de 50.', String newLineString,
	'Balance = 40')! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/31/2023 18:02:46'!
test17transferNetReportOfEmptyAccountOutputs0

	| account1 result report |
	
	account1 := ReceptiveAccount new.
	
	report := TransferNetReport for: account1 .
	result := report process.
	
	self assert: result equals: 0! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/31/2023 18:08:23'!
test18transferNetReportOfAccountOutputsBalance

	| account1 account2 result report |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 70 on: account1.
	Withdraw register: 30 on: account2.
	Transfer for: 5 from: account1 to: account2.
	Transfer for: 50 from: account2 to: account1 .
	
	report := TransferNetReport for: account1 .
	result := report process.
	
	self assert: result equals: 45.! !

!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'JV 5/31/2023 18:09:07'!
test19transferNetReportOfPortfolioWithInnerTransactionsOutputs0

	| account1 account2 result report pf |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 70 on: account1.
	Withdraw register: 30 on: account2.
	Transfer for: 5 from: account1 to: account2.
	Transfer for: 50 from: account2 to: account1 .
	
	pf := Portfolio new.
	pf add: account1.
	pf add: account2.
		
	report := TransferNetReport for: pf .
	result := report process.
	
	self assert: result equals: 0.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'JV 5/28/2023 21:21:48'!
deposits

	^self transactions select: [ :transaction | transaction isKindOf: Deposit]! !

!Account methodsFor: 'reports' stamp: 'fd 5/29/2023 16:46:17'!
incomingTransfers

	^self transactions select: [ :transaction | transaction isKindOf: IncomingTransferEnd]! !

!Account methodsFor: 'reports' stamp: 'fd 5/29/2023 16:46:24'!
outgoingTransfers

	^self transactions select: [ :transaction | transaction isKindOf: OutgoingTransferEnd]! !

!Account methodsFor: 'reports' stamp: 'fd 5/29/2023 21:52:58'!
processForReport: report 
	self subclassResponsibility.! !

!Account methodsFor: 'reports' stamp: 'JV 5/28/2023 21:21:43'!
withdrawals

	^self transactions select: [ :transaction | transaction isKindOf: Withdraw]! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'JV 5/31/2023 17:57:42'!
processForReport: aReport 
	aReport processPortfolio: self.
	accounts do: [:account | account processForReport: aReport].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'JV 5/31/2023 17:52:06'!
processForReport: aReport 
	aReport processReceptiveAccount: self.
	transactions do: [:transaction | transaction processForReport: aReport ].! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'fd 5/29/2023 21:55:37'!
processForReport: aReport 
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'fd 5/29/2023 21:55:59'!
processForReport: aReport 
	aReport processDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferEnd category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferEnd
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferEnd methodsFor: 'as yet unclassified' stamp: 'fd 5/29/2023 16:51:19'!
initializeFor: aTransfer
	transfer := aTransfer.! !


!TransferEnd methodsFor: 'value' stamp: 'fd 5/29/2023 16:53:56'!
value
	^transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferEnd class' category: 'Portfolio-Solucion'!
TransferEnd class
	instanceVariableNames: ''!

!TransferEnd class methodsFor: 'as yet unclassified' stamp: 'fd 5/29/2023 16:53:23'!
for: transfer
	^self new initializeFor: transfer.! !


!classDefinition: #IncomingTransferEnd category: 'Portfolio-Solucion'!
TransferEnd subclass: #IncomingTransferEnd
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!IncomingTransferEnd methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 20:24:15'!
affectBalance: aBalance
	^aBalance + self value.! !

!IncomingTransferEnd methodsFor: 'as yet unclassified' stamp: 'fd 5/29/2023 21:56:25'!
processForReport: aReport 
	aReport processIncomingTransferEnd: self! !


!classDefinition: #OutgoingTransferEnd category: 'Portfolio-Solucion'!
TransferEnd subclass: #OutgoingTransferEnd
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!OutgoingTransferEnd methodsFor: 'as yet unclassified' stamp: 'JV 5/28/2023 20:24:24'!
affectBalance: aBalance
	^aBalance - self value.! !

!OutgoingTransferEnd methodsFor: 'as yet unclassified' stamp: 'fd 5/29/2023 21:56:33'!
processForReport: aReport 
	aReport processOutgoingTransferEnd: self! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'initialization' stamp: 'fd 5/29/2023 21:56:42'!
processForReport: aReport 
	aReport processWithdraw: self! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'reports' stamp: 'fd 5/29/2023 21:50:49'!
initializeFor: anAccount
	account := anAccount! !

!Report methodsFor: 'reports' stamp: 'fd 5/29/2023 21:49:32'!
process
	account processForReport: self.
	^self result.! !

!Report methodsFor: 'reports' stamp: 'fd 5/29/2023 21:51:17'!
processDeposit: aDeposit 
	self subclassResponsibility.! !

!Report methodsFor: 'reports' stamp: 'fd 5/29/2023 21:51:25'!
processIncomingTransferEnd: anIncomingTransferEnd 
	self subclassResponsibility.! !

!Report methodsFor: 'reports' stamp: 'fd 5/29/2023 21:51:32'!
processOutgoingTransferEnd: anOutgoingTransferEnd
	self subclassResponsibility.! !

!Report methodsFor: 'reports' stamp: 'JV 5/31/2023 17:53:26'!
processPortfolio: aPortfolio 
	self subclassResponsibility.! !

!Report methodsFor: 'reports' stamp: 'JV 5/31/2023 17:52:52'!
processReceptiveAccount: anAccounts 
	self subclassResponsibility.! !

!Report methodsFor: 'reports' stamp: 'fd 5/29/2023 21:51:36'!
processWithdraw: aWithdraw 
	self subclassResponsibility.! !

!Report methodsFor: 'reports' stamp: 'fd 5/29/2023 16:01:27'!
result
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'fd 5/29/2023 21:50:33'!
for: account
	^self new initializeFor: account! !


!classDefinition: #AccountSummaryReport category: 'Portfolio-Solucion'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'balance result'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReport methodsFor: 'reports' stamp: 'fd 5/29/2023 22:01:44'!
addSummaryFor: transaction withDescription: description
	self notYetImplemented.! !

!AccountSummaryReport methodsFor: 'reports' stamp: 'fd 5/29/2023 16:37:26'!
initialize
	balance := 0.
	result := ''.
	! !

!AccountSummaryReport methodsFor: 'reports' stamp: 'fd 5/29/2023 21:58:19'!
processDeposit: aDeposit 
	balance := aDeposit affectBalance: balance.
	result := result, 'Depósito por ', aDeposit value asString, '.', String newLineString.! !

!AccountSummaryReport methodsFor: 'reports' stamp: 'fd 5/29/2023 22:00:13'!
processIncomingTransferEnd: anIncomingTransferEnd 
	balance := anIncomingTransferEnd affectBalance: balance.
	result := result, 'Entrada por transferencia de ', anIncomingTransferEnd value asString, '.', String newLineString.! !

!AccountSummaryReport methodsFor: 'reports' stamp: 'fd 5/29/2023 21:59:57'!
processOutgoingTransferEnd: anOutgoingTransferEnd 
	balance := anOutgoingTransferEnd affectBalance: balance.
	result := result, 'Salida por transferencia de ', anOutgoingTransferEnd value asString, '.', String newLineString.! !

!AccountSummaryReport methodsFor: 'reports' stamp: 'JV 5/31/2023 17:57:13'!
processPortfolio: aPortfolio 
	"No hace nada"! !

!AccountSummaryReport methodsFor: 'reports' stamp: 'JV 5/31/2023 17:56:54'!
processReceptiveAccount: aReceptiveAccount 
	"No hace nada"
	! !

!AccountSummaryReport methodsFor: 'reports' stamp: 'fd 5/29/2023 21:58:55'!
processWithdraw: aWithdraw
	balance := aWithdraw affectBalance: balance.
	result := result, 'Extracción por ', aWithdraw value asString, '.', String newLineString.! !

!AccountSummaryReport methodsFor: 'reports' stamp: 'fd 5/29/2023 16:16:46'!
result
	^result, 'Balance = ', balance asString! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'balance transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'reports' stamp: 'fd 5/29/2023 16:38:24'!
initialize
	transferNet := 0.
	! !

!TransferNetReport methodsFor: 'reports' stamp: 'JV 5/31/2023 17:50:31'!
result
	^transferNet! !


!TransferNetReport methodsFor: 'processing' stamp: 'JV 5/31/2023 18:06:53'!
processDeposit: aDeposit 
	"No hace nada"! !

!TransferNetReport methodsFor: 'processing' stamp: 'JV 5/31/2023 18:08:13'!
processIncomingTransferEnd: anIncomingTransferEnd 
	transferNet := anIncomingTransferEnd affectBalance: transferNet ! !

!TransferNetReport methodsFor: 'processing' stamp: 'JV 5/31/2023 18:07:48'!
processOutgoingTransferEnd: anOutgoingTransferEnd 
	transferNet := anOutgoingTransferEnd affectBalance: transferNet! !

!TransferNetReport methodsFor: 'processing' stamp: 'JV 5/31/2023 18:08:40'!
processPortfolio: aPortfolio 
	"No hace nada"! !

!TransferNetReport methodsFor: 'processing' stamp: 'JV 5/31/2023 18:00:00'!
processReceptiveAccount: aReceptiveAccount 
	"No hace nada"! !

!TransferNetReport methodsFor: 'processing' stamp: 'JV 5/31/2023 18:08:58'!
processWithdraw: aWithdraw 
	"No hace nada"! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value outgoingTransferEnd incomingTransferEnd'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'JV 5/28/2023 20:23:22'!
initializeWithAmount: anAmount outgoingTransferEnd: anOutgoingTransferEnd incomingTransferEnd: anIncomingTransferEnd
	value := anAmount.
	outgoingTransferEnd := anOutgoingTransferEnd.
	incomingTransferEnd := anIncomingTransferEnd.! !


!Transfer methodsFor: 'accessing' stamp: 'fd 5/29/2023 16:56:35'!
incomingEnd
	^incomingTransferEnd.! !

!Transfer methodsFor: 'accessing' stamp: 'fd 5/29/2023 16:56:21'!
outgoingEnd
	^outgoingTransferEnd.! !

!Transfer methodsFor: 'accessing' stamp: 'JV 5/28/2023 19:56:24'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'JV 5/27/2023 09:45:58'!
ensureAccount: aSenderAccount isNotTheSameAs: aReceiverAccount
	
	(aSenderAccount = aReceiverAccount ) ifTrue: [self error: 'CannotTransferToOwnAccount']! !

!Transfer class methodsFor: 'instance creation' stamp: 'JV 5/22/2023 21:56:33'!
ensureAmountIsPositive: anAmount

	anAmount > 0 ifFalse: [self error: 'TransferForNonPositiveAmountIsNotAllowed'].
	

	! !

!Transfer class methodsFor: 'instance creation' stamp: 'fd 5/29/2023 16:52:35'!
for: anAmount from: aSenderAccount to: aReceiverAccount
	
	| incomingTransferEnd outgoingTransferEnd transfer |
	self ensureAmountIsPositive: anAmount.
	self ensureAccount: aSenderAccount isNotTheSameAs: aReceiverAccount.
	
	transfer := self new.
	
	outgoingTransferEnd := (OutgoingTransferEnd for: transfer).
	incomingTransferEnd := (IncomingTransferEnd for: transfer).
	
	transfer initializeWithAmount: anAmount outgoingTransferEnd: outgoingTransferEnd incomingTransferEnd: incomingTransferEnd.	
	
	aSenderAccount register: outgoingTransferEnd.
	aReceiverAccount register: incomingTransferEnd.
	
	^transfer.
	
	

	! !
