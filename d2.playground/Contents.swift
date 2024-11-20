import Cocoa
import AppKit

let name = "Taylor"
let age = 36
let message = "Hello, \(name), I am \(age) years old."
print(message)

print("5x5 is \(5 * 5)")

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        let dateString = formatter.string(from: value)
        appendLiteral(dateString)
    }
}

print("Today's date is \(Date()).")

extension String.StringInterpolation {
    mutating func appendInterpolation(format value: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut

        if let result = formatter.string(from: value as NSNumber) {
            appendLiteral(result)
        }
    }
}

print("High score: \(1000)")
// by naming the paramater as per the mutating function, can format 2 ways
print("High score: \(format: 1000)")

extension String.StringInterpolation {
    mutating func appendInterpolation(_ values: [String], empty defaultValue: @autoclosure () -> String) {
        if values.count == 0 {
            appendLiteral(defaultValue())
        } else {
            appendLiteral(values.joined(separator: ", "))
        }
    }
}

let names = ["Malcolm", "Jayne", "Kaylee"]
print("Crew: \(names, empty: "No one").")

extension String.StringInterpolation {
    mutating func appendInterpolation(if condition: @autoclosure () -> Bool, _ literal: StringLiteralType) {
        guard condition() else { return }
        appendLiteral(literal)
    }
}

let doesSwiftRock = true
print("Swift rocks: \(if: doesSwiftRock, "(*)")")
print("Swift rocks \(doesSwiftRock ? "(*)" : "")")

struct Person {
    var type: String
    var action: String
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ person: Person) {
        appendLiteral("I'm a \(person.type) and I'm gonna \(person.action).")
    }
}

let hater = Person(type: "hater", action: "hate")
print("Status check: \(hater)")

extension String.StringInterpolation {
    mutating func appendInterpolation(_ person: Person, count: Int) {
        let action = String(repeating: "\(person.action) ", count: count)
        appendLiteral("\n\(person.type.capitalized)s gonna \(action)")
    }
}

let player = Person(type: "player", action: "play")
let heartBreaker = Person(type: "heart-breaker", action: "break")
let faker = Person(type: "faker", action: "fake")

print("Let's sing: \(player, count: 5) \(hater, count: 5) \(heartBreaker, count: 5) \(faker, count: 5)")

struct Person2: Encodable {
    var type: String
    var action: String
}

extension String.StringInterpolation {
    mutating func appendInterpolation<T: Encodable>(debug value: T) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let result = try? encoder.encode(value) {
            let str = String(decoding: result, as: UTF8.self)
            appendLiteral(str)
        }
    }
}

let faker2 = Person2(type: "faker", action: "fake")
print("Here's some data: \(debug: faker2)")

struct ColoredString: ExpressibleByStringInterpolation {
    // this nested struct is our scratch pad that assembles an attributed string from various interpolations
    struct StringInterpolation: StringInterpolationProtocol {
        // this is where we store the attributed string as we're building it
        var output = NSMutableAttributedString()

        // some default attribute to use for text
        var baseAttributes: [NSAttributedString.Key: Any] = [.font: NSFont(name: "Georgia-Italic", size: 64) ?? .systemFont(ofSize: 64), .foregroundColor: NSColor.black]

        // this initializer is required, and can be used as a performance optimization
        init(literalCapacity: Int, interpolationCount: Int) { }

        // called when we need to append some raw text
        mutating func appendLiteral(_ literal: String) {
            // print it out so you can see how it's called at runtime
            print("Appending \(literal)")

            // give it our base styling
            let attributedString = NSAttributedString(string: literal, attributes: baseAttributes)

            // add it to our scratchpad string
            output.append(attributedString)
        }

        // called when we need to append a colored message to our string
        mutating func appendInterpolation(message: String, color: NSColor) {
            // print it out again
            print("Appending \(message)")

            // take a copy of our base attributes and apply the color
            var coloredAttributes = baseAttributes
            coloredAttributes[.foregroundColor] = color

            // wrap it in a new attributed string and add it to our scratchpad
            let attributedString = NSAttributedString(string: message, attributes: coloredAttributes)
            output.append(attributedString)
        }
    }

    // the final attributed string, once all interpolations have finished
    let value: NSAttributedString

    // create an instance from a literal string
    init(stringLiteral value: String) {
        self.value = NSAttributedString(string: value)
    }

    // create an instance from an interpolated string
    init(stringInterpolation: StringInterpolation) {
        self.value = stringInterpolation.output
    }
}

// now try it out!
let str: ColoredString = "\(message: "Red", color: .red), \(message: "White", color: .white), \(message: "Blue", color: .blue)"

//checkpoint
let temp_c = 22
let temp_f = temp_c * 9 / 5 + 32
print("\(temp_c)°C is equivalent to \(temp_f)°F")
