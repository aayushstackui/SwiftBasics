import UIKit

// game class
class Game {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) initialized")
    }
    deinit {
        print("\(name) deallocated")
    }
}

// strong, weak, and unowned References
class Player {
    let name: String
    var strongGame: Game?  // strong reference
    weak var weakGame: Game?  // weak reference
    unowned var unownedGame: Game  // unowned reference

    init(name: String, game: Game) {
        self.name = name
        self.unownedGame = game
    }
}

var game1: Game? = Game(name: "Kingdom come deliverance")
var player1: Player? = Player(name: "Aayush", game: game1!)

player1?.strongGame = game1 // strong ref
game1 = nil // won't deallocate because player1 holds a strong reference

player1?.weakGame = player1?.strongGame
player1?.strongGame = nil // now, weakGame becomes nil


// retain cycle
class Developer {
    let name: String
    var game: Game?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) deallocated")
    }
}

var dev: Developer? = Developer(name: "Trevor")
var game: Game? = Game(name: "GTA 6")

dev?.game = game
game = nil
dev = nil // neither object deallocates

// retain cycle on delocating
class DeveloperFixed {
    let name: String
    weak var game: Game?  // using weak here..

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) deallocated")
    }
}

var devFixed: DeveloperFixed? = DeveloperFixed(name: "Aayush")
var gameFixed: Game? = Game(name: "Outlast")

devFixed?.game = gameFixed
gameFixed = nil
devFixed = nil

// associated type in protocols
protocol GameEngine {
    associatedtype Platform
    func run(on platform: Platform)
}

class PCGameEngine: GameEngine {
    func run(on platform: String) {
        print("Running game on \(platform) PC")
    }
}

class ConsoleGameEngine: GameEngine {
    func run(on platform: Int) {
        print("Running game on console version \(platform)")
    }
}

let pcGame = PCGameEngine()
pcGame.run(on: "Windows")

let consoleGame = ConsoleGameEngine()
consoleGame.run(on: 5)

// copy on write
struct GameSettings {
    var settings: [String] = ["High Resolution", "First-Person"]
}

var settings1 = GameSettings()
var settings2 = settings1  // not copied yet so it is sharing memory

settings2.settings.append("Ultra Graphics") // now, I have changed the stored value

print("Settings 1: \(settings1.settings)")
print("Settings 2: \(settings2.settings)")
