

//class and OOP principles
class FactoryWorker {
    var name: String
    var age: Int
    var experience: Int
    
    init(name: String, age: Int, experience: Int) {
        self.name = name
        self.age = age
        self.experience = experience
    }
    
    func work() {
        print("\(name) is working in the factory.")
    }
}

let worker = FactoryWorker (name: "Amit", age: 23, experience: 1)
worker.work()

//struct
struct WorkShift {
    var startHour: Int
    var endHour: Int
    
    func shiftDuration() -> Int {
        return endHour - startHour
    }
}

//optional chaining
class Factory {
    var supervisor: FactoryWorker?
}

let factory = Factory()
factory.supervisor?.work()

//loops
let workerName = ["Aayush", "James", "Prateek"]
for worker in workerName {
    print("\(worker) is assigned to a shift.")
}

//types of properties
class Machine {
    static let factoryName = "Tech Consulting"
    let id: Int
    var isRunning: Bool
    
    init(id: Int, isRunning: Bool) {
        self.id = id
        self.isRunning = isRunning
    }
}

//protocols
protocol Worker {
    var name: String { get set }
    func performTask()
}

class Engineer: Worker {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func performTask() {
        print("\(name) is repairing machines.")
    }
}

//extension
extension FactoryWorker {
    func takeBreak() {
        print("\(name) is taking a break.")
    }
}

//let worker = FactoryWorker(name: "Ravi", age: 23, experience: 3)
worker.takeBreak()
