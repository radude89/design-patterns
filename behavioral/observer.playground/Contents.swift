import Foundation

/// # Observer
///
/// - Description: defines a one-to-many dependency between objects so that when one object changes state, all its depenendents are notified and updated automatically.
///
/// ## Advantages:
///     - abstract coupling between Subject and Observer.
///     - support for broadcast communication.
///
/// ## Disadvantages:
///     - unexpected updates - subjects are notified in random order.
///
/// ## When to use it:
///     - when an abstraction has two aspects, one dependent on the other.
///     - when a change to one object requires changing others, and you don't know how many objects need to be changed.
///     - when an object should be able to notify other objects without making assumptions about who these objects are.
///     - ⛳️ Use the Observer pattern when changes to the state of one object may require changing other objects, and the actual set of objects is unknown beforehand or changes dynamically.
///     - 🥌 Use the pattern when some objects in your app must observe others, but only for a limited time or in specific cases.
///
/// More to read: https://refactoring.guru/design-patterns/observer

/// **Example**

final class Subject {
    var state: String = { UUID().uuidString }()
    
    private lazy var observers: [Observer] = []
    
    func attach(_ observer: Observer) {
        print("Observer \(observer.observerID) is now subscribed to subject having state \(state)")
        observers.append(observer)
    }
    
    func detach(_ observer: Observer) {
        print("Observer \(observer.observerID) has now unsubscribed.")
        observers.removeAll { $0 === observer }
    }
    
    func notify() {
        observers.forEach { $0.update(subject: self) }
    }
    
    func performComputing() {
        print("Doing some stuff...")
        state = UUID().uuidString
        print("Subject state changed to \(state).")
        notify()
    }
}

protocol Observer: AnyObject {
    var observerID: String { get set }
    
    func update(subject: Subject)
}

extension Observer {
    func update(subject: Subject) {
        print("Observer \(observerID) is updating. Request coming from subject with state: \(subject.state)")
    }
}

final class ConcreteObserver: Observer {
    var observerID: String
    
    init(observerID: String) {
        self.observerID = observerID
    }
}


let subject = Subject()
let observerA = ConcreteObserver(observerID: "A")
let observerB = ConcreteObserver(observerID: "B")

subject.attach(observerA)
subject.attach(observerB)

subject.performComputing()
subject.detach(observerA)
subject.performComputing()
