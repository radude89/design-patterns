import Foundation

/// # Chain of responsibility
///
/// - Description: avoid coupling the sender of a request to its receiver by giving more than one object
///  a chance to handle the request. Chain the receiving objects and pass the request along the chain
///  until an object handles it.
///
/// ## Advantages:
///     - reduced coupling.
///     - added flexibility in assigning responsibilities to objects.
///
/// ## Disadvantages:
///     - receipt isn't guaranteed. Since a request has no explicity receiver, there's no guarantee
///     it'll be handled - the request can fall off the end of the chain without ever being handled.
///     A request can also ho unhandled when the chain is not configured properly.
///
/// ## When to use it:
///     - when more than one object may handle a request, and the handler isn't known a priori.
///     The handler should be ascertained automatically.
///     - you want to issue a request to one of several objects without specifying the receiver explicitly.
///     - the set of objects that can handle a request should be specified dynamically.
///     - 🐂 Use the Chain of Responsibility pattern when your program is expected to process
///     different kinds of requests in various ways, but the exact types of requests and their
///     sequences are unknown beforehand.
///     - 🐞 Use the pattern when it’s essential to execute several handlers in a particular order.
///     - 🐊 Use the pattern when the set of handlers and their order are supposed to change at runtime.
///
/// More to read: https://refactoring.guru/design-patterns/chain-of-responsibility

/// **Example**

protocol Handler {
    var next: Handler? { get set }
    
    func handle(request: String) -> String?
}

extension Handler {
    func handle(request: String) -> String? {
        return next?.handle(request: request)
    }
}

class HumanHandler: Handler {
    
    var next: Handler?

    func handle(request: String) -> String? {
        if request == "🍕" {
            return "Human: I will handle that 🍕."
        } else {
            print("Human")
            return next?.handle(request: request)
        }
    }
}

class MonkeyHandler: Handler {
    
    var next: Handler?

    func handle(request: String) -> String? {
        if request == "🍌" {
            return "Monkey: I will handle that 🍌."
        } else {
            print("Monkey")
            return next?.handle(request: request)
        }
    }
}

class SquirrelHandler: Handler {
    
    var next: Handler?
    
    func handle(request: String) -> String? {
        if request == "🥜" {
            return "Squirrel: I will handle that 🥜."
        } else {
            print("Squirrel")
            return next?.handle(request: request)
        }
    }
}

class DogHandler: Handler {
    var next: Handler?
    
    func handle(request: String) -> String? {
        if request == "🦴" {
            return "Dog: I will handle that 🦴."
        } else {
            print("Dog")
            return next?.handle(request: request)
        }
    }
}

var humanHandler = HumanHandler()
var monkeyHandler = MonkeyHandler()
var squirrelHandler = SquirrelHandler()
let dogHandler = DogHandler()

humanHandler.next = monkeyHandler
monkeyHandler.next = squirrelHandler
squirrelHandler.next = dogHandler

print(humanHandler.handle(request: "🦴")!)
print(humanHandler.handle(request: "🥜")!)
print(humanHandler.handle(request: "🍌")!)
print(humanHandler.handle(request: "🍕")!)
