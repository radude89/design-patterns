import Foundation

/// # Decorator
///
/// - Description: Attach additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.
///
/// ## Advantages:
///     - more flexibility than static instance.
///     - avoid feature-laden classes high up in the hierarchy.
///     - a decorator and its component aren't identical.
///     - lots of little objects.
///
/// ## Disadvantages:
///     - it’s hard to remove a specific wrapper from the wrappers stack.
///     - it’s hard to implement a decorator in such a way that its behavior doesn’t depend on the order in the decorators stack.
///     - the initial configuration code of layers might look pretty ugly.
///
/// ## When to use it:
///     - to add responsibilities to individual objects dynamically and transparently, that is, without affecting other objects.
///     - for responsibilities that can be withdrawn.
///     - when extension by subclassing is impractical. Sometimes a large number of independent extensions are possible and would produce an explosion of subclasses to support every combination. Or a class definition may be hidden or otherwise unavailable for subclassing.
///     - 🐺 Use the Decorator pattern when you need to be able to assign extra behaviors to objects at runtime without breaking the code that uses these objects.
///     - 🐞 Use the pattern when it’s awkward or not possible to extend an object’s behavior using inheritance.
///
/// More to read: https://refactoring.guru/design-patterns/decorator.

/// **Example**

protocol UIComponent {
    var name: String { get }
    
    func draw()
}

extension UIComponent {
    func draw() {
        print("Draw \(name).")
    }
}

struct TextView: UIComponent {
    var name: String { "TextView" }
}

struct ScrollView: UIComponent {
    var name: String { "ScrollView" }
}

protocol Decorator: UIComponent {
    var component: UIComponent { get set }
}

struct BorderDecorator: Decorator {
    var component: UIComponent
    var name: String { component.name }
    let borderWidth: Float
    
    func draw() {
        // implement a custom draw method or just delegate
        component.draw()
        print("Adding border capabilities to \(component.name).")
    }
}

struct ScrollDecorator: Decorator {
    var component: UIComponent
    var name: String { component.name }
    
    func draw() {
        // implement a custom draw method or just delegate
        component.draw()
        print("Adding scroll capabilities to \(component.name).")
    }
    
    func scroll(to y: Float) {}
}

let textView = TextView()
let borderDecorator = BorderDecorator(component: textView, borderWidth: 15)
borderDecorator.draw()

let scrollView = ScrollView()
let scrollDecorator = ScrollDecorator(component: scrollView)
let scrollBorderDecorator = BorderDecorator(component: scrollDecorator, borderWidth: 1)
scrollBorderDecorator.draw()
