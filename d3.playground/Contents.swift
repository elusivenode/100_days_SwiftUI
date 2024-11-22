import Cocoa

var scores = Array<Int>()
scores.append(85)
scores.append(90)
scores.append(88)
print(scores)
// remove the second item
scores.remove(at: 1)
print(scores)

var family = [String]()
family.append("Hamish")
family.append("Becky")
family.append("Jack")
family.append("Sophie")
print(family)
family.sort()
print(family)

var ints = [1, 2, 3, 4, 5, 20, 29, 19, 10, 9]
ints.reverse()
print(ints)
for i in ints {
    print(i)
}

family.reverse()
print(family)

var person: [String: Any] = ["name": "Hamish", "age": 48, "job": "Software Engineer"]
print(person)
// optional
print(person["name"])
print(person["name"]!)
var family2 = [person]
print(family2)
family2.append(["name": "Becky", "age": 42, "job": "Accountant"])
family2.append(["name": "Jack", "age": 10, "job": "Student"])
family2.append(["name": "Sophie", "age": 10, "job": "Student"])
print(family2)
for member in family2 {
    print(member)
}
print(family2[0]["name"]!)

// sets
var colours = Set<String>()
colours.insert("red")
colours.insert("green")
colours.insert("blue")
colours.insert("blue")
print(colours)

// enums
enum r: CustomStringConvertible {
    case success
    case failure
    
    var description: String {
        switch self {
        case .success:
            return "Success"
        case .failure:
            return "Failure"
        }
    }
}
print(r.self)
print(r.success)
print(r.failure)
