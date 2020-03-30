import Foundation

/// # Strategy
///
/// - Description: define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it.
///
/// ## Advantages:
///     - an alternative to subclassing.
///     - strategies elimnate conditional statements.
///     - You can swap algorithms used inside an object at runtime.
///     - You can isolate the implementation details of an algorithm from the code that uses it.
///
/// ## Disadvantages:
///     - Clients must be aware of the differences between strategies to be able to select a proper one.
///
/// ## When to use it:
///     - many related classes differ only in their behavior. Strategies provide a way to configure a class with one of many behaviors.
///     - you need different variants of an algorithm.
///     - an algorithm uses data that clients shouldn't know about.
///     - a class defines many behaviors, and these appear as multiple conditional statements in its operations.
///     - 🍏 Use the Strategy pattern when you want to use different variants of an algorithm within an object and be able to switch from one algorithm to another during runtime.
///     - ☔️ Use the Strategy when you have a lot of similar classes that only differ in the way they execute some behavior.
///     - 🥭 Use the pattern to isolate the business logic of a class from the implementation details of algorithms that may not be as important in the context of that logic.
///     - 🥥 Use the pattern when your class has a massive conditional operator that switches between different variants of the same algorithm.
///
/// More to read: https://refactoring.guru/design-patterns/strategy

/// **Example**

protocol Strategy {
    func execute(a: Decimal, b: Decimal) -> Decimal
}

struct AddStrategy: Strategy {
    func execute(a: Decimal, b: Decimal) -> Decimal {
        a + b
    }
}

struct MutliplicationStrategy: Strategy {
    func execute(a: Decimal, b: Decimal) -> Decimal {
        a * b
    }
}

struct DivisionStrategy: Strategy {
    func execute(a: Decimal, b: Decimal) -> Decimal {
        a / b
    }
}

struct Context {
    private var strategy: Strategy
    
    init(strategy: Strategy) {
        self.strategy = strategy
    }
    
    func execute(a: Decimal, b: Decimal) -> Decimal{
        strategy.execute(a: a, b: b)
    }
    
    mutating func setStrategy(_ strategy: Strategy) {
        self.strategy = strategy
    }
}

enum Action: CaseIterable {
    case addition
    case multiplication
    case division
}

let a: Decimal = 5
let b: Decimal = 7
let randomAction = Action.allCases.randomElement()!
var context = Context(strategy: AddStrategy())

switch randomAction {
case .addition:
    print("Picked strategy is addition.")
    print(context.execute(a: a, b: b))
    
case .division:
    print("Picked strategy is division.")
    context.setStrategy(DivisionStrategy())
    print(context.execute(a: a, b: b))
    
case .multiplication:
    print("Picked strategy is multiplication.")
    context.setStrategy(MutliplicationStrategy())
    print(context.execute(a: a, b: b))
}
