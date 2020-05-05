import UIKit

/// # Abstract Factory
///
/// - Description: Provide an interface for creating families of related or dependent objects without specifying
/// their concrete classes.
///
/// ## Advantages:
///     - isolates concrete classes.
///     - makes exchanging product families easy.
///     - promotes consistency among products.
///
/// ## Disadvantage:
///     - supporting new kinds of products is difficult.
///
/// ## When to use it:
///     - a system should be independent of how its products are created,
///     composed, and represented.
///     - a system should be configured with one of multiple families of products.
///     - a family of related product objects is designed to be used together,
///     and you need to enforce this constraint.
///     - you want to provide a class library of products, and you want to reveal
///     just their interfaces, not their implementations.
///     - 🏄‍♂️ Use the Abstract Factory when your code needs to work with various
///     families of related products, but you don’t want it to depend on the
///     concrete classes of those products—they might be unknown beforehand
///     or you simply want to allow for future extensibility.
///
/// More to read: https://refactoring.guru/design-patterns/abstract-factory

/// **Example**

protocol WidgetFactory {
    func makeWindow() -> Window
    func makeView() -> View
    func makeActionButton() -> Button
}

protocol Window {
    var name: String { get }
    var children: [View] { get set }
}

protocol View {
    var name: String { get }
    var parent: View? { get set }
}

protocol Button {
    var name: String { get }
    
    func onTap()
}

struct LightWindow: Window {
    var name: String { "Light window" }
    var children: [View] = []
}

struct DarkWindow: Window {
    var name: String { "Dark window" }
    var children: [View] = []
}

struct LightView: View {
    var name: String { "Light view" }
    var parent: View?
}

struct DarkView: View {
    var name: String { "Dark view" }
    var parent: View?
}

struct LightButton: Button {
    var name: String { "Light button" }
    
    func onTap() {
        print("LightButton tapped")
    }
}

struct DarkButton: Button {
    var name: String { "Dark button" }
    
    func onTap() {
        print("DarkButton tapped")
    }
}

struct LightModeWidgetFactory: WidgetFactory {
    func makeWindow() -> Window { LightWindow() }
    func makeView() -> View { LightView() }
    func makeActionButton() -> Button { LightButton() }
}

struct DarkModeWidgetFactory: WidgetFactory {
    func makeWindow() -> Window { DarkWindow() }
    func makeView() -> View { DarkView() }
    func makeActionButton() -> Button { DarkButton() }
}

struct Application {
    var widgetFactory: WidgetFactory
    
    lazy var window = widgetFactory.makeWindow()
    lazy var view = widgetFactory.makeView()
    lazy var actionButton = widgetFactory.makeActionButton()
    
    mutating func load() {
        print("Loaded window: \(window.name), view: \(view.name), button: \(actionButton.name)")
        actionButton.onTap()
    }
}

var lightMode = Application(widgetFactory: LightModeWidgetFactory())
lightMode.load()

var darkMode = Application(widgetFactory: DarkModeWidgetFactory())
darkMode.load()
