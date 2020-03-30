import Foundation

/// # Mediator
///
/// - Description: define an object that encapsulates how a set of objects interact. Mediator promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you try their interaction independently.
///
/// ## Advantages:
///     - it limits subclassing.
///     - it decouples colleagues.
///     - it simplifies object protocols.
///     - it abstracts how objects cooperate.
///     - it centralizes control.
///
/// ## Disadvantages:
///     - Over time a mediator can evolve into a God Object.
///
/// ## When to use it:
///     - a set of objects communicate in a well-defined but complex ways. The resulting interdependencies are unstructured and difficult to understand.
///     - reusing an object is difficult because it refers to and communicates with many other objects.
///     - a behavior that's distributed between several classes should be customizable without a lot of subclassing.
///     - 🍭 Use the Mediator pattern when it’s hard to change some of the classes because they are tightly coupled to a bunch of other classes.
///     - 🍫 Use the pattern when you can’t reuse a component in a different program because it’s too dependent on other components.
///     - 🍣 Use the Mediator when you find yourself creating tons of component subclasses just to reuse some basic behavior in various contexts.
///
/// More to read: https://refactoring.guru/design-patterns/mediator

/// **Example**

protocol Mediator: AnyObject {
    func notify(sender: BaseComponent, event: String)
}

class BaseComponent {
    fileprivate weak var mediator: Mediator?
    
    init(_ mediator: Mediator? = nil) {
        self.mediator = mediator
    }
    
    func update(mediator: Mediator?) {
        self.mediator = mediator
    }
}

final class Component1: BaseComponent {
    func doA() {
        print("Component 1 does A.")
        mediator?.notify(sender: self, event: "A")
    }
    
    func doB() {
        print("Component 1 does B.\n")
        mediator?.notify(sender: self, event: "B")
    }
}

final class Component2: BaseComponent {
    func doC() {
        print("Component 2 does C.")
        mediator?.notify(sender: self, event: "C")
    }
    
    func doD() {
        print("Component 2 does D.")
        mediator?.notify(sender: self, event: "D")
    }
}

final class ConcreteMediator: Mediator {
    
    private var comp1: Component1
    private var comp2: Component2
    
    init(_ comp1: Component1, _ comp2: Component2) {
        self.comp1 = comp1
        self.comp2 = comp2
        
        comp1.update(mediator: self)
        comp2.update(mediator: self)
    }
    
    func notify(sender: BaseComponent, event: String) {
        if event == "A" {
            print("Mediator reacts on A and triggers following operations:")
            comp2.doC()
        } else if event == "D" {
            print("Mediator reacts on D and triggers following operations:")
            comp1.doB()
            comp2.doC()
        }
    }
}

let component1 = Component1()
let component2 = Component2()

let mediator = ConcreteMediator(component1, component2)
print("Client triggers operation A.")
component1.doA()

print("\nClient triggers operation D.")
component2.doD()
