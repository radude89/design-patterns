import UIKit

/// # Builder
///
/// - Description: separate the construction of a complex object from its representation
/// so that the same construction process can create different representations.
///
/// ## Advantages:
///     - let's yo vary a product's internal representation.
///     - isolates code for construction and representation.
///     - gives finer control over the construction process.
///
/// ## When to use it:
///     - the algorithm for creating a complex object should be independent
///     of the parts that make up the object and how they are assembled.
///     - the construction process must allow different representations
///     for the object that's constructed.
///     - 🧗‍♀️ Use the Builder pattern to get rid of a “telescopic constructor”
///     (a constructor with multiple parameters).
///     - 🏋️‍♀️ Use the Builder pattern when you want your code to be able to
///     create different representations of some product (for example,
///     stone and wooden houses).
///     - ⛹️ Use the Builder to construct Composite trees or other complex objects.
///
/// More to read:
///     - https://refactoring.guru/design-patterns/builder
///     - https://theswiftdev.com/swift-builder-design-pattern

/// **Example**

protocol Theme {
    var mainColor: UIColor { get set }
    var name: String { get }
}

struct LightTheme: Theme {
    var mainColor: UIColor = .white
    var name: String { "Light" }
}

struct DarkTheme: Theme {
    var mainColor: UIColor = .black
    var name: String { "Black" }
}

protocol ThemeBuilder {
    var textColor: UIColor { get set }
    var backgroundColor: UIColor { get set }
    
    func buildThemeTexts()
    func buildThemeViews()
    func buildThemeButtons()
    func retrieveTheme() -> Theme
}

final class LightThemeBuilder: ThemeBuilder {
    var textColor: UIColor = .white
    var backgroundColor: UIColor = .white
    
    private var theme = LightTheme()
    
    func buildThemeTexts() { print("Creating light theme texts.") }
    func buildThemeViews() { print("Creating light theme views.") }
    func buildThemeButtons() { print("Creating light theme buttons.") }
    
    func retrieveTheme() -> Theme {
        return theme
    }
}

final class DarkThemeBuilder: ThemeBuilder {
    var textColor: UIColor = .black
    var backgroundColor: UIColor = .black
    
    private var theme = LightTheme()
    
    func buildThemeTexts() { print("Creating dark theme texts.") }
    func buildThemeViews() { print("Creating dark theme views.") }
    func buildThemeButtons() { print("Creating dark theme buttons.") }
    
    func retrieveTheme() -> Theme {
        return theme
    }
}

final class ThemeDirector {
    var themeBuilder: ThemeBuilder
    
    init(themeBuilder: ThemeBuilder) {
        self.themeBuilder = themeBuilder
    }
    
    func buildPartialTheme() {
        themeBuilder.buildThemeViews()
        themeBuilder.buildThemeButtons()
    }
    
    func buildCompleteTheme() {
        themeBuilder.buildThemeViews()
        themeBuilder.buildThemeButtons()
        themeBuilder.buildThemeTexts()
    }
}

let lightThemeBuilder = LightThemeBuilder()
lightThemeBuilder.buildThemeTexts()
lightThemeBuilder.buildThemeViews()
lightThemeBuilder.buildThemeButtons()
let lightTheme = lightThemeBuilder.retrieveTheme()
print(lightTheme)

// director
let darkThemeBuilder = DarkThemeBuilder()
let director = ThemeDirector(themeBuilder: darkThemeBuilder)
director.buildPartialTheme()

director.themeBuilder = lightThemeBuilder
director.buildCompleteTheme()
