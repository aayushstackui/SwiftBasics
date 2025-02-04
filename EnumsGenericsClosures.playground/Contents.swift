import Foundation

// non-escaping closure
func performAction(action: () -> Void) {
    print("Leatherface is getting ready...")
    action()
    print("Action completed!")
}

performAction {
    print("Leatherface attacks with a chainsaw!")
}

//escaping closure
@MainActor
class ClosureStorage {
    var escapingClosures: [() -> Void] = []
    
    func storeClosureForLater(_ closure: @escaping () -> Void) {
        escapingClosures.append(closure)
    }
    
    func executeStoredClosures() {
        for closure in escapingClosures {
            closure()
        }
    }
}

let closureStorage = ClosureStorage()
closureStorage.storeClosureForLater {
    print("Leatherface's attack was stored for later execution.")
}

// execute stored closures safely
Task { @MainActor in
    closureStorage.executeStoredClosures()
}

// trailing Closure
func executeKill(withWeapon weapon: String, killAction: () -> Void) {
    print("Leatherface picks up his \(weapon).")
    killAction()
}

executeKill(withWeapon: "Chainsaw") {
    print("Leatherface swings his weapon violently!")
}

// auto Closure
func confirmKill(_ killCount: @autoclosure () -> Int) {
    print("Leatherface's confirmed kill count: \(killCount())")
}

confirmKill(5 + 3)


// enum with raw values
enum Weapon: String {
    case chainsaw = "Chainsaw"
    case hammer = "Hammer"
    case meatHook = "Meat Hook"
}

// enum with associated values
enum KillRecord {
    case singleKill(weapon: Weapon, victim: String)
    case massacre(weapon: Weapon, count: Int)
}

let kill1 = KillRecord.singleKill(weapon: .chainsaw, victim: "John")
let kill2 = KillRecord.massacre(weapon: .hammer, count: 10)

func describeKill(_ kill: KillRecord) {
    switch kill {
    case .singleKill(let weapon, let victim):
        print("Leatherface killed \(victim) using a \(weapon.rawValue).")
    case .massacre(let weapon, let count):
        print("Leatherface killed \(count) people using a \(weapon.rawValue).")
    }
}

describeKill(kill1)
describeKill(kill2)

// generic function
func describeWeapon<T>(name: T) {
    print("Leatherface's weapon is: \(name)")
}

describeWeapon(name: "Chainsaw")
describeWeapon(name: 101)

// generic struct
struct KillInfo<T, U> {
    let killCount: T
    let weaponUsed: U
}

let record1 = KillInfo(killCount: 20, weaponUsed: "Chainsaw")
let record2 = KillInfo(killCount: "Twenty", weaponUsed: Weapon.hammer)

print("Kill Record 1 - Kills: \(record1.killCount), Weapon: \(record1.weaponUsed)")
print("Kill Record 2 - Kills: \(record2.killCount), Weapon: \(record2.weaponUsed)")

enum KillData<T> {
    case weapon(T)
    case count(Int)
}

// Explicitly specify types when using the enum
let leatherfaceWeapon = KillData<String>.weapon("Chainsaw")
let leatherfaceKillCount = KillData<Int>.count(100)

switch leatherfaceWeapon {
case .weapon(let weapon):
    print("Leatherface used: \(weapon)")
case .count(let count):
    print("Leatherface's kill count: \(count)")
}
