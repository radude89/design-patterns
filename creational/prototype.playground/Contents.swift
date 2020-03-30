import UIKit

/// # Prototype
///
/// - Description: specify the kinds of objects to create using a prototypical instance, and create new objects by copying this prototype.
///
/// ## Advantages:
///     - adding and removing products at run-time.
///     - specifying new objects by varying values.
///     - specifying new objects by varying structure.
///     - reduced subclassing.
///     - configuring an application with classes dynamically.
///
/// ## Disadvantages:
///     - cloning complex objects that have circular references might be very tricky
///
/// ## When to use it:
///     - when the classes to instantiate are specified at run-time, for example, by dynamic loading.
///     - to avoid building a class hierarcy of factories that parallels the class hierarchy of products.
///     - when instances of a class can have one of only a few different combinations of state.
///     - 🧘‍♀️ Use the Prototype pattern when your code shouldn’t depend on the concrete classes of objects that you need to copy.
///     - 🏂 Use the pattern when you want to reduce the number of subclasses that only differ in the way they initialize their respective objects. Somebody could have created these subclasses to be able to create objects with a specific configuration.
///
/// More to read: https://theswiftdev.com/swift-prototype-design-pattern/

/// **Example #1**

protocol Drawable {
    func draw(at position: CGPoint)
    func clone() -> Self
}

struct Shape: Drawable {
    var shapeName: String
    
    func draw(at position: CGPoint) { print("Added shape") }
    func clone() -> Self { Shape(shapeName: shapeName) }
}

struct Artwork: Drawable {
    var index: Int
    
    func draw(at position: CGPoint) { print("Added artwork") }
    func clone() -> Self { Artwork(index: index) }
}


struct Canvas {
    var drawable: Drawable
    
    func draw() {
        let shape = drawable.clone()
        shape.draw(at: .zero)
        
        let artwork = drawable.clone()
        artwork.draw(at: CGPoint(x: 1, y: 1))
    }
}

let initialDrawable = Artwork(index: 0)

var canvas = Canvas(drawable: initialDrawable)
canvas.draw()

canvas.drawable = Shape(shapeName: "Test")
canvas.draw()

/// **Example #2**

struct Player {
    var name: String
    var health: Int = 0
    var damage: Int = 0
    
    func clone() -> Player { Player(name: name) }
}

var warrior = Player(name: "warrior")
warrior.health = 100
warrior.damage = 1000

var worker = warrior.clone()
worker.name = "worker"
worker.health = 500
worker.damage = 1

var hero = warrior.clone()
hero.name = "hero"
hero.health = 1000
hero.damage = 1000

print("\(warrior.name), health: \(warrior.health), damage: \(warrior.damage)")
print("\(worker.name), health: \(worker.health), damage: \(worker.damage)")
print("\(hero.name), health: \(hero.health), damage: \(hero.damage)")
