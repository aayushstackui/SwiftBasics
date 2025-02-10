import UIKit

enum TransactionType {
    case deposit(Double)
    case withdrawal(Double)
    case transfer(Double, toAccount: Int)
    case interestApplication(Double)
}

struct Transaction {
    let type: TransactionType
    let date: Date
}

protocol Bank {
    var accountNumber: Int { get }
    var balance: Double { get set }
    var transactions: [Transaction] { get set }
    
    func performTransaction(_ transaction: Transaction)
    func accountSummary() -> String
}

extension Bank {
    func accountSummary() -> String {
        return "Account \(accountNumber) Summary:\nBalance: \(balance)\nTransactions: \(transactions.map { "\($0.type) on \($0.date)" })"
    }
}

class RegularAccount: Bank {
    let accountNumber: Int
    var balance: Double
    var transactions: [Transaction] = []
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func performTransaction(_ transaction: Transaction) {
        switch transaction.type {
        case .deposit(let amount):
            balance += amount
        case .withdrawal(let amount):
            if balance >= amount {
                balance -= amount
            } else {
                print("Not enough funds.")
                return
            }
        case .transfer(let amount, let toAccount):
            if balance >= amount {
                balance -= amount
            } else {
                print("Not enough funds.")
                return
            }
        default:
            break
        }
        transactions.append(transaction)
    }
}

class SavingAccount: Bank {
    let accountNumber: Int
    var balance: Double
    var transactions: [Transaction] = []
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func performTransaction(_ transaction: Transaction) {
        switch transaction.type {
        case .deposit(let amount):
            balance += amount
        case .withdrawal(let amount):
            if balance >= amount {
                balance -= amount
            } else {
                print("Not enough funds.")
                return
            }
        case .interestApplication(let amount):
            balance += amount
        default:
            break
        }
        transactions.append(transaction)
    }
    
    func interestCalculation(P: Double, R: Double, T: Double) {
        let interest = P * R * T
        let interestTransaction = Transaction(type: .interestApplication(interest), date: Date())
        performTransaction(interestTransaction)
    }
}

class BankSystem {
    var accounts: [Bank] = []
    
    func addAccount(_ account: Bank) {
        accounts.append(account)
    }
    
    func totalBalance() -> Double {
        return accounts.reduce(0) { $0 + $1.balance }
    }
    
    func findAccount(by number: Int) -> Bank? {
        return accounts.first { $0.accountNumber == number }
    }
    
    func performTransaction(from accountNumber: Int, transaction: Transaction) {
        if let account = findAccount(by: accountNumber) {
            account.performTransaction(transaction)
        } else {
            print("There is no such Account.")
        }
    }
}

let bankSystem = BankSystem()

let savingAccount = SavingAccount(accountNumber: 21421531553, balance: 2000)
let regularAccount = RegularAccount(accountNumber: 21421531554, balance: 3000)

bankSystem.addAccount(savingAccount)
bankSystem.addAccount(regularAccount)

let depositTransaction = Transaction(type: .deposit(214), date: Date())
bankSystem.performTransaction(from: 21421531553, transaction: depositTransaction)

let withdrawalTransaction = Transaction(type: .withdrawal(2000.64), date: Date())
bankSystem.performTransaction(from: 21421531553, transaction: withdrawalTransaction)

savingAccount.interestCalculation(P: 1000, R: 0.05, T: 1)

print(savingAccount.accountSummary())
print(regularAccount.accountSummary())
print("Total balance across all accounts: \(bankSystem.totalBalance())")
