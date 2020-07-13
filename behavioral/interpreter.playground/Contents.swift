import Foundation

/// # Interpreter
///
/// - Description: given a language, define a representation for its grammar along with an
/// interpreter that uses the representation to interpret sentences in a language.
///
/// ## Advantages:
///     - it's easy to change and extend the grammar.
///     - implementing the grammar is easy.
///
/// ## Disadvantages:
///     - complex grammars are hard to maintain.
///
/// ## When to use it:
///     - when there is a language to interpret, and you can represent
///     statements in the language as abstract syntax trees.
///     - the grammar is simple.
///     - efficiency is not a critical concern.
///
/// More to read: https://github.com/kingreza/Swift-Interpreter

/// **Example**

protocol IntegerExpression {
    func evaluate(_ context: IntegerContext) -> Int
    func replace(character: Character,
                 integerExpression: IntegerExpression) -> IntegerExpression
    func copied() -> IntegerExpression
}

final class IntegerContext {
    private var data: [Character: Int] = [:]

    func lookup(name: Character) -> Int {
        return data[name]!
    }

    func assign(expression: IntegerVariableExpression,
                value: Int) {
        data[expression.name] = value
    }
}

final class IntegerVariableExpression: IntegerExpression {
    let name: Character

    init(name: Character) {
        self.name = name
    }

    func evaluate(_ context: IntegerContext) -> Int {
        return context.lookup(name: name)
    }

    func replace(character name: Character,
                 integerExpression: IntegerExpression) -> IntegerExpression {
        if name == self.name {
            return integerExpression.copied()
        } else {
            return IntegerVariableExpression(name: self.name)
        }
    }

    func copied() -> IntegerExpression {
        return IntegerVariableExpression(name: name)
    }
}

final class AddExpression: IntegerExpression {
    private var operand1: IntegerExpression
    private var operand2: IntegerExpression

    init(op1: IntegerExpression,
         op2: IntegerExpression) {
        self.operand1 = op1
        self.operand2 = op2
    }

    func evaluate(_ context: IntegerContext) -> Int {
        return operand1.evaluate(context) + operand2.evaluate(context)
    }

    func replace(character: Character,
                 integerExpression: IntegerExpression) -> IntegerExpression {
        return AddExpression(op1: operand1.replace(character: character,
                                                   integerExpression: integerExpression),
                             op2: operand2.replace(character: character,
                                                   integerExpression: integerExpression))
    }

    func copied() -> IntegerExpression {
        return AddExpression(op1: operand1, op2: operand2)
    }
}

var context = IntegerContext()

var a = IntegerVariableExpression(name: "A")
var b = IntegerVariableExpression(name: "B")
var c = IntegerVariableExpression(name: "C")

// a + (b + c)
var expression = AddExpression(op1: a,
                               op2: AddExpression(op1: b, op2: c))

context.assign(expression: a, value: 2)
context.assign(expression: b, value: 1)
context.assign(expression: c, value: 3)

var result = expression.evaluate(context)
print(result)
