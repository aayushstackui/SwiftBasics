import UIKit

enum TransactionType {
    case deposit(Double)
    case withdrawal(Double)
    case transfer(Double, toAccount: Int)
    case interestApplication(Double)
}

enum TransactionError: Error {
    case insufficientFunds(currentBalance: Double)
    case accountNotFound(accountNumber: Int)
    case invalidTransaction
}

struct Transaction {
    let type: TransactionType
    let date: Date
}

protocol Bank {
    var accountNumber: Int { get }
    var balance: Double { get }
    var transactions: [Transaction] { get }
    
    func performTransaction(_ transaction: Transaction) throws
    func accountSummary() -> String
}

extension Bank {
    func accountSummary() -> String {
        return """
        Account : \(accountNumber) Summary:
        Balance: \(balance)
        Transactions: \(transactions.map { "\($0.type) on \($0.date)" })
        """
    }
}

class RegularAccount: Bank {
    let accountNumber: Int
    private(set) var balance: Double
    private(set) var transactions: [Transaction] = []
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func performTransaction(_ transaction: Transaction) throws {
        switch transaction.type {
        case .deposit(let amount):
            balance += amount
        case .withdrawal(let amount):
            if balance >= amount {
                balance -= amount
            } else {
                throw TransactionError.insufficientFunds(currentBalance: balance)
            }
        case .transfer(let amount, _):
            if balance >= amount {
                balance -= amount
            } else {
                throw TransactionError.insufficientFunds(currentBalance: balance)
            }
        default:
            throw TransactionError.invalidTransaction
        }
        transactions.append(transaction)
    }
}

class SavingAccount: Bank {
    let accountNumber: Int
    private(set) var balance: Double
    private(set) var transactions: [Transaction] = []
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func performTransaction(_ transaction: Transaction) throws {
        switch transaction.type {
        case .deposit(let amount):
            balance += amount
        case .withdrawal(let amount):
            if balance >= amount {
                balance -= amount
            } else {
                throw TransactionError.insufficientFunds(currentBalance: balance)
            }
        case .interestApplication(let amount):
            balance += amount
        default:
            throw TransactionError.invalidTransaction
        }
        transactions.append(transaction)
    }
    
    func interestCalculation(P: Double, R: Double, T: Double) {
        let interest = P*R*T
        let interestTransaction = Transaction(type: .interestApplication(interest), date: Date())
        try? performTransaction(interestTransaction)
    }
}

class BankSystem {
    var bankAccounts: [Bank] = []
    
    // add an account to the bank system
    func addAccount(_ account: Bank) {
        bankAccounts.append(account)
    }
    
    // calculating total balance of all accounts
    func totalBalance() -> Double {
        return bankAccounts.reduce(0) { $0 + $1.balance }
    }
    
    // find an account by account numberbm
    func findAccount(by number: Int) -> Bank? {
        return bankAccounts.first { $0.accountNumber == number }
    }
    
    // performing specific account transaction
    func performTransaction(from accountNumber: Int, transaction: Transaction) {
        if let account = findAccount(by: accountNumber) {
            do {
                try account.performTransaction(transaction)
            } catch TransactionError.insufficientFunds(let currentBalance) {
                print("Transaction has failed due to Insufficient funds. Current balance: \(currentBalance)")
            } catch TransactionError.accountNotFound(let accountNumber) {
                print("Transaction has failed due to  Account not found. Account number: \(accountNumber)")
            } catch TransactionError.invalidTransaction {
                print("Transaction has failed due to Invalid transaction.")
            } catch {
                print("Transaction has failed due to Unknown error.")
            }
        } else {
            print("Transaction failed: There is no such account.")
        }
    }
}

// testing

// create the bank system
let bankSystem = BankSystem()

// creating accounts
let savingAccount = SavingAccount(accountNumber: 21421531553, balance: 2000)
let regularAccount = RegularAccount(accountNumber: 21421531554, balance: 3500)

// adding accounts to the bank system
bankSystem.addAccount(savingAccount)
bankSystem.addAccount(regularAccount)

// adding another account
let anotherRegularAccount = RegularAccount(accountNumber: 21421531555, balance: 1500)
bankSystem.addAccount(anotherRegularAccount)

// checking total accounts
print("Total accounts in the bank system: \(bankSystem.bankAccounts.count)")

// getting total balance
print("Total balance across all accounts: \(bankSystem.totalBalance())")

// finding an account
if let foundAccount = bankSystem.findAccount(by: 21421531553) {
    print("Found account: \(foundAccount.accountNumber), Balance: \(foundAccount.balance)")
} else {
    print("Account not found.")
}

// finding a non existing account
if let foundAccount = bankSystem.findAccount(by: 999899999) {
    print("Found account: \(foundAccount.accountNumber), Balance: \(foundAccount.balance)")
} else {
    print("Account not found.")
}

// performing a deposit
let depositTransaction = Transaction(type: .deposit(500), date: Date())
bankSystem.performTransaction(from: 21421531553, transaction: depositTransaction)

// verifying the new balance
if let updatedAccount = bankSystem.findAccount(by: 21421531553) {
    print("New balance after deposit: \(updatedAccount.balance)")
}

// performing a withdrawal
let withdrawalTransaction = Transaction(type: .withdrawal(1000), date: Date())
bankSystem.performTransaction(from: 21421531553, transaction: withdrawalTransaction)

// verifying the new balance
if let updatedAccount = bankSystem.findAccount(by: 21421531553) {
    print("New balance after withdrawal: \(updatedAccount.balance)")
}

// attempting to withdraw more than available balance
let largeWithdrawal = Transaction(type: .withdrawal(5000), date: Date())
bankSystem.performTransaction(from: 21421531553, transaction: largeWithdrawal)

// transfering money
let transferTransaction = Transaction(type: .transfer(1000, toAccount: 21421531555), date: Date())
bankSystem.performTransaction(from: 21421531554, transaction: transferTransaction)

// verifying balance after transfer
if let updatedAccount = bankSystem.findAccount(by: 21421531554) {
    print("New balance after transfer: \(updatedAccount.balance)")
}

// interest
if let savingAcc = bankSystem.findAccount(by: 21421531553) as? SavingAccount {
    savingAcc.interestCalculation(P: savingAcc.balance, R: 0.05, T: 1)
    print("New balance after interest application: \(savingAcc.balance)")
}

// print account summaries
print(savingAccount.accountSummary())
print(regularAccount.accountSummary())
print(anotherRegularAccount.accountSummary())
