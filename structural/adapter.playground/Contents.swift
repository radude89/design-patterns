import Foundation

/// # Adapter
///
/// - Description: convert the interface of a class into another interface clients expect. Adapter classes work together that couldn't otherwise because of incompatibile interfaces.
///
/// ## Advantages:
///     - introduces only one object, and no additional pointer indirection is needed to get to the adaptee.
///
/// ## When to use it:
///     - you want to use an existing class, and its interface does not match the one you need.
///     - you want to create a reusable class that cooperates with unrelated or unforseen classes, that is, classes that don't necessarily have compatible interfaces.
///     - (object adapter only) you need to use several existing subclasses, but it's impractical to adapt their interface by subclassing ever one. An object adapter can adapt the interface to its parent class.
///     - 🎳 Use the Adapter class when you want to use some existing class, but its interface isn’t compatible with the rest of your code.
///     - 🎰 Use the pattern when you want to reuse several existing subclasses that lack some common functionality that can’t be added to the superclass.
///
/// More to read: https://refactoring.guru/design-patterns/adapter

/// **Example**

protocol Circle {
    var radius: Int { get set }
}

struct RoundHole: Circle {
    var radius: Int
    
    func fits(_ circle: Circle) -> Bool {
        return radius >= circle.radius
    }
}

struct RoundPeg: Circle {
    var radius: Int
}

struct SquarePeg {
    let width: Int
}

struct SquarePegAdapter: Circle {
    let squarePeg: SquarePeg
    var radius: Int
    
    init(squarePeg: SquarePeg) {
        self.squarePeg = squarePeg
        radius = Int(sqrt(2.0) * Double(squarePeg.width) / 2)
    }
}

let hole = RoundHole(radius: 5)
let roundPeg = RoundPeg(radius: 5)
print(hole.fits(roundPeg))

let smallSquarePeg = SquarePeg(width: 5)
let smallPegAdapter = SquarePegAdapter(squarePeg: smallSquarePeg)
print(hole.fits(smallPegAdapter))

let largeSquarePeg = SquarePeg(width: 1)
let largePegAdapter = SquarePegAdapter(squarePeg: largeSquarePeg)
print(largePegAdapter.radius)
print(hole.radius)
print(hole.fits(largePegAdapter))
