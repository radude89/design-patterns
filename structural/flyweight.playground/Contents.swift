import UIKit

/// # Flyweight
///
/// - Description: use sharing to support large numbers of fine-grained objects efficiently.
///
/// ## Advantages:
///     - You can save lots of RAM, assuming your program has tons of similar objects.
///
/// ## Disadvantages:
///     - You might be trading RAM over CPU cycles when some of the context data needs to be recalculated each time somebody calls a flyweight method.
///     - The code becomes much more complicated. New team members will always be wondering why the state of an entity was separated in such a way.
///
/// ## When to use it:
///     - Apply this pattern when all of the following are true:
///         - an application uses a large number of objects.
///         - storage costs are high because of the sheer quantity of objects.
///         - most object state can be made extrinsic.
///         - many groups of objects may be replaced by relatively few shared objects once extrinsic state is removed.
///         - the application doesn't depend on object identity.
///     - 🐤 Use the Flyweight pattern only when your program must support a huge number of objects which barely fit into available RAM.
///
/// More to read: https://refactoring.guru/design-patterns/flyweight

/// **Example**

/// Flyweight - intrinsic state.
class Particle {
    private(set) var color: UIColor
    private(set) var spriteLocation: String

    init(color: UIColor, spriteLocation: String) {
        self.color = color
        self.spriteLocation = spriteLocation
    }
}

enum ParticleFactory {
    static var particles: [Particle] = []
    
    static func makeParticle(color: UIColor, spriteLocation: String) -> Particle {
        if let particle = particles.first(where: { $0.spriteLocation == spriteLocation && $0.color == color }) {
            return particle
        }
        
        let particle = Particle(color: color, spriteLocation: spriteLocation)
        particles.append(particle)
        
        return particle
    }
}

/// Extrinsic state
class MovingParticle {
    var point: CGPoint
    var vector: CGVector
    var speed: Double
    let particle: Particle
    
    init(point: CGPoint, vector: CGVector, speed: Double, particle: Particle) {
        self.point = point
        self.vector = vector
        self.speed = speed
        self.particle = particle
    }
    
    func move() {
        print("Is moving...")
        print("Particle moved at (\(point.x), \(point.y)) with speed \(speed).")
    }
}

var gameParticles: [MovingParticle] = []

let particle1 = ParticleFactory.makeParticle(color: .red, spriteLocation: "/sprites/particle_1.sprite")
let particle2 = ParticleFactory.makeParticle(color: .yellow, spriteLocation: "/sprites/particle_2.sprite")
let particle3 = ParticleFactory.makeParticle(color: .blue, spriteLocation: "/sprites/particle_3.sprite")

let movingParticle1 = MovingParticle(point: .zero, vector: CGVector(), speed: 25, particle: particle1)
let movingParticle2 = MovingParticle(point: .zero, vector: CGVector(), speed: 35, particle: particle2)
let movingParticle3 = MovingParticle(point: .zero, vector: CGVector(), speed: 45, particle: particle3)

gameParticles.append(movingParticle1)
gameParticles.append(movingParticle2)
gameParticles.append(movingParticle3)

gameParticles.forEach { $0.move() }
