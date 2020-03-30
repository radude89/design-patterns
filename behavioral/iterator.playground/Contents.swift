import Foundation

/// # Iterator
///
/// - Description: provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
///
/// ## Advantages:
///     - it supports variations in the traversal of an aggregate.
///     - iterators simplify the Aggregate interface.
///     - more than one traversal can be pending on aggregate.
///     - you can iterate over the same collection in parallel because each iterator object contains its own iteration state.
///     - for the same reason, you can delay an iteration and continue it when needed.
///
/// ## When to use it:
///     - to access an aggregate object's contents without exposing its internal representation.
///     - to support multiple traversals of aggregate objects.
///     - to provide a uniform interface for traversing different aggregate structures (that is, to support polymorphic iteration).
///     - 🥠 Use the Iterator pattern when your collection has a complex data structure under the hood, but you want to hide its complexity from clients (either for convenience or security reasons).
///     - 🍥 Use the pattern to reduce duplication of the traversal code across your app.
///     - 🍦 Use the Iterator when you want your code to be able to traverse different data structures or when types of these structures are unknown beforehand.
///
/// More to read: https://refactoring.guru/design-patterns/iterator

/// **Example 1**

final class WordsCollection: Sequence {
    
    fileprivate lazy var items: [String] = []
    
    func append(_ item: String) {
        items.append(item)
    }
    
    func makeIterator() -> WordsIterator { WordsIterator(self) }
    
}

final class WordsIterator: IteratorProtocol {
    
    private let collection: WordsCollection
    private var index = 0
    
    init(_ collection: WordsCollection) {
        self.collection = collection
    }
    
    func next() -> String? {
        defer { index += 1 }

        return index < collection.items.count ? collection.items[index] : nil
    }
    
}

let words = WordsCollection()
words.append("First")
words.append("Second")
words.append("Third")

for word in words {
    print(word)
}

/// **Example 2**

struct CountdownIterator: IteratorProtocol {
    typealias Element = Int
    
    var count: Int
    
    mutating func next() -> Int? {
        if count  == 0 {
            return nil
        } else {
            count -= 1
            return count
        }
    }
}

struct Countdown: Sequence {
    typealias Iterator = CountdownIterator
    
    let count: Int
    
    init(count: Int) {
        self.count = count
    }
    
    func makeIterator() -> CountdownIterator { CountdownIterator(count: count) }
}

var iterator = CountdownIterator(count: 5)
iterator.next()
iterator.next()
iterator.next()
iterator.next()
iterator.next()
iterator.next()

var countdown = Countdown(count: 3)
countdown.map { $0 * $0 }
countdown.allSatisfy { $0.isMultiple(of: 2) }
countdown.max()
countdown.sorted()
countdown.forEach { print($0) }
