
//: Playground - noun: a place where people can play
//: Course - Hacking With Swift
//: Author - B. E. S. Hall

import UIKit

// =====================
// Variables & Constants
// =====================

// A constant
let constant: String = "A constant"
// constant = 3 // error: cannot assign to value: 'constant' is a 'let' constant

// A Variable
var variable: String = "A variable"
variable = "New Variable"

// =====================
// Data Types
// =====================

// String
let string: String = "A string"

// Int
let int: Int = 1

// Float/Double
let float: Float = 1.0
let double: Double = 1.0 // Swift defaults to a double with type inference

// Boolean
let bool: Bool = false // or true

// Optional
// An optional is a special swift type that 'may' have a value of the specified type.
// Otherwise it is nil. Think of the syntax as asking whether the variable contains a value of not.
// More on this later, here is the syntax.
var optional: String? = nil // or any <type>?

// =====================
// Operators
// =====================

// Mathematical operators
// +, -, *, /

// Assignment
// =, +=, -=, *=, /=

// Equality
// ==, !=, >, >=, <, <=

// =====================
// String Interpolation
// =====================
let strInterp: String = "Hello"
let TATLTUAE: Int = 42
let fish: Any = "fish!"
print("\(strInterp) World!\nThe answer to life, the universe, and everything is \(TATLTUAE)\nThanks for all the \(fish)")

// Can also concatenate Strings with + operator

// =====================
// Collections
// =====================

// ARRAYS
// Creation
var dblArr = [Double]() // or var dblArr: [Double] = []
dblArr = [1.0,2.0,3.0,4.0]
// let arr = [<Type>](); arr = [<Type>, <Type>, <Type>, ...]; // or use type inference off the bat with arr = [<Type>, <Type>, <Type>, ...]
// Can access and edit individual elemnets with
dblArr[0] = 10

// also default values
var defaultDblArr = Array(repeating: 0.0, count: 3)
var defulatStrArr = Array(repeating: "Spam", count: 10)

// Can APPEND (MUST BE SAME TYPE) via concatenation
var dblArr2 = dblArr + [5,6,7,8]
// or in place
dblArr += [5,6,7,8]
// or type method
dblArr.append(5) //... for single addition
dblArr.append(contentsOf: [6,7,8]) //... for a sequence

// And all similar remove methods
dblArr.remove(at: 0) // remove at index position. This also returns the removed value
// Also have .removeAll(), removeFirst(), removeLast(), removeSuberange(bounds: Range<Int>) type methods plus many more!

// Can replace part of array
dblArr.replaceSubrange(0...2, with: [10,11,12])
// Can get the <Type> of the array with
type(of: dblArr)

// Size of collection
var cnt: Int = dblArr.count

// DICTIONARIES - Hashable key-value
var personDict: [String: Any] = [
    "title": "Dr",
    "first": "Ben",
    "last": "Hall",
    "age": 27
            ]

let hadBirthday = true
if hadBirthday { personDict["age"] = 28 }

// Can get keys of dictionary with
let dictKeys = Array(personDict.keys)

// As with arrays, there are many Type methods for dictionaries for manipulating the elements.

// ENUMS - A first class Type that allows you to create own types
enum WeatherType {
    case sun
    case cloud
    case rain
    case wind
    case snow
}

let weather: WeatherType = .sun

switch weather {
case .sun: print("Shorts time!") // Note the type inference of 'weather' - no need to specify 'WeatherType.sun' in the case!
case .cloud: print("Meh...")
case .rain: print("Pack an umbrella!")
case .wind: print("Maybe time to fly a kite?")
case .snow: print("SNOWDAY!")
}


// Enums can also have values attached to their them!
enum AnotherWeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

let windyWeather: AnotherWeatherType = .wind(speed: 5)

switch windyWeather {
case .wind(let whatSpeed) where whatSpeed < 10:
    print("A little breezy")
case .wind(let whatSpeed) where whatSpeed > 10:
    print("WINDY!")
default: print("") // REMEMBER: Switch-case must be exhaustive
}


// ==============================
// Conditional Statements (logic)
// ==============================
var logicTest: Bool = true
if logicTest {
    print("Logical!")
} else {
    print("Not so logical!")
}

// Can have multiple logical statements including || (or), && (and)

// ==============================
// Loops
// ==============================

// For loops
// - Through a range
for _ in 1 ... 5 { // _ if not interested in the counter. x ... y is a countable range from x to, and including, y
 print("Spam")
}

for i in 1 ..< 5 { // setting a variable for range counter allows us to use it. x ..< y is another countable range from x up to, but not including y.
    print(i)
}

// - Through an array
let nameArray = ["Jane", "Joe"]
for name in nameArray {
    print(name)
}

// or...
for arrIndex in 0 ..< nameArray.count {
    print(nameArray[arrIndex])
}

// or.. enumerate for both!
for (index,entry) in nameArray.enumerated() {
    print("Name at index \(index) is: \(entry)")
}

// While Loops
// run until condition is invalidated, or loop broken from
var whileCnt = 0
while true {
    if whileCnt == TATLTUAE {
        print("It took \(whileCnt) iterations to reach TATLTUAE")
        break
    }
    
    whileCnt += 1
}


// ==============================
// Switch - Case
// ==============================
// Another type of conditional logic
// Evaluates a series of 'case' series until a condition is met, then 'switches' that code on.
// No fallthrough unless specifically stated
// Must be exhaustive (i.e. include all enum options, type possibilities, or a default condition)
let cases: Int = 3
switch cases {
case 0:
    print("Switched on case 0")
case 1:
    print("Switched on case 1")
case 2:
    print("Switched on case 2")
case 3:
    print("Switched on case 3 with fallthrough")
    fallthrough
default:
    print("Default switch")
}

// The case can also be a countable range
switch cases {
case 0 ..< 3:
    print("Case in within range 0 - 2 (inclusive)")
default:
    print("Case is >2")
}


// ==============================
// Functions
// ==============================
// Re-usable code snippets
// Really, I function should do one thing, and only that thing.
// This should mean the function is clear, and short.
// Non-returning
func add(value a: Int, to b: Int) -> () {
    print("\(a) + \(b) = \(a+b)")
}

add(value: 1, to: 10)

// A returning function has the returning type declared
func addAndReturn(value a: Int, to b: Int) -> Int {
    return(a+b)
}
print("10 + 20 = \(addAndReturn(value: 10, to: 20))")

"""
    The add functions above have used 'external' (e.g. 'value' and 'to')
    and 'internal' parameter names (e.g. 'a' and 'b')
    EXTERNAL parameter names makes it easier to describe descriptive api functions
    whilst INTERNAL names can be shorthand for actual function implementation
    Putting an "_" as the external name tells swift that there should be no EXTERNAL name required (e.g. call for add would be add(1,2))
    Functions can be combined with switch statements to good effect!
"""

// ==============================
// More on Optionals
// ==============================
func isSwiftOptional(answer: Bool) -> String? {
    if answer {
        return nil
    } else {
        return "Correct. Swift is too awesome to be optional (OPTIONAL UNPACK ME!)"
    }
}

let wrappedOutput: String?
wrappedOutput = isSwiftOptional(answer: false)
// this will need to be unpacked
// if we know it has a value we use the syntax:
print(wrappedOutput!)
// If we want to be safer we use 'if let' statement
if let unwrappedOutput = wrappedOutput {
    print("If let unwrapped contained \"\(unwrappedOutput)\"")
} else {
    print("The value is nil")
}

// Or a variant that returns is the guard statement
func guardUnwrapperFunction() {
    guard let unwrappedOutput = wrappedOutput else {
        print("This code is executed if an optional CANNOT be unwrapped (i.e. is nil)")
        return
    }
    print("But now have acess to the unwrappedOutput,\n\t\"\(unwrappedOutput)\"\nbeyond any condition statement blocks.")
}

guardUnwrapperFunction()


// Optional chaining
// Allows us to evaluate whether a chain of commands may fail at some point due to existence of optionals (or rahter absence of an object/var)
// For example, say we have this function that can return an optional
func canReturnOptional(switchOn: Int) -> String? {
    switch switchOn {
    case 0 ... 2: return "A string"
    default: return nil
    }
}

// Based on the input to this function a nil could be returned instead of a String so explicit unpacking can be dangerous.
// Also if we chained a type method after this (e.g. uppercased() to make the string uppercase) it will fail without some form of unpacking unless we chain it!
// Like so:
// let willFailFromUnpackedOptional = canReturnOptional(switchOn: 0).uppercased()
let possibleNilOrString = canReturnOptional(switchOn: 3)?.uppercased()
let anotherPossibleNilOrString = canReturnOptional(switchOn: 0)?.uppercased()

// The Nil Coalescing Operator allows us to evaluate the existence of an unpackable optional (non nil), but if nil assign a defined output
// Sytax is: nonOptionalOutput = varOrFuncThatMayReturnOptional ?? returnedValueIfPriorEvaluatedToNil
// ?? is the NCO
let unpackedOptionalOrNCO = (canReturnOptional(switchOn: 3) ?? "unknown").uppercased()

// so the constant possibleOptional will be an optional in this case
print("Done")

