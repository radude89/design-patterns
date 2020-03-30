import Foundation

/// # Composite
///
/// - Description: compose objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly.
///
/// ## Advantages:
///     - defines class hierarchies consisting of primitive objects and composite objects.
///     - makes the client simple.
///     - makes it easier to add new kinds of components.
///
/// ## Disadvantages:
///     - can make your design overly general. The disadvantage of making it easy to add new components is that it makes it harder to restrict the components of a composite. Sometimes you want a composite to have only certain components. With Composite, you can't rely on the type system to enforce those constraints for you. You'll have to use run-time checks instead.
///     - it might be difficult to provide a common interface for classes whose functionality differs too much. In certain scenarios, you’d need to overgeneralize the component interface, making it harder to comprehend.
///
/// ## When to use it:
///     - you want to represent part-whole hierarchies of objects.
///     - you want clients to be able to ignore the difference between compositions of objects and individual objects. Clients will treat all objects in the composite structure uniformly.
///     - 🐫 Use the Composite pattern when you have to implement a tree-like object structure.
///     - 🦀 Use the pattern when you want the client code to treat both simple and complex elements uniformly.
///
/// More to read: https://refactoring.guru/design-patterns/composite

/// **Example**

protocol UIComponent {
    var name: String { set get }
    
    func applyTheme()
}

extension UIComponent {
    func applyTheme() { print("Apply theme to \(name)") }
}

struct LabelComponent: UIComponent {
    var name: String
}

struct TextViewComponent: UIComponent {
    var name: String
}

struct ViewComponent: UIComponent {
    var name: String
    var children: [UIComponent]
    
    func applyTheme() {
        print("Applying theme to \(name)")
        children.forEach { $0.applyTheme() }
    }
    
    mutating func add(_ component: UIComponent) {
        print("added new component")
        children.append(component)
    }
    
    mutating func remove(at index: Int) {
        print("removing component")
        children.remove(at: index)
    }
}

struct Drawer {
    let components: [UIComponent]
    
    func draw() {
        components.forEach { $0.applyTheme() }
    }
}

let labels = [LabelComponent(name: "label_1"), LabelComponent(name: "label_2"), LabelComponent(name: "label_3")]
let textViews = [TextViewComponent(name: "textview_1"), TextViewComponent(name: "textview_2")]

var view = ViewComponent(name: "view_1", children: labels)
textViews.forEach { view.add($0) }
view.remove(at: 2)

var mainView = ViewComponent(name: "main_view", children: [view])

let drawer = Drawer(components: [mainView])
drawer.draw()
