import UIKit

//var greeting = "Hello, playground"
//
//print("Hello World!")
//
///*
// int =
// */
//
//// 1. String
//
//var address = "This is my first statement" //Implicit Variable
//print(address)
//
//var name : String = "This is my first statement" //Explicit Variable
//print(name)
//
////constant - let
//let age = 20
//print(age)
//
//name = "This is second statement"
//
//let rollNo = 20
//print(20)
//
//// Float
//var num : Float = 2.14
//print(num)

//Data Types
var age: Int = 23
var height: Double = 5.10
var weight: Float = 190.42
var name: String = "Aayush"
var isDeveloper: Bool = true

print(age, height, weight, name, isDeveloper)

//Collections

//Array
var marks : [Int] = [3,5,2,6,7,8,9,10]
marks.append(11)
marks.remove(at: 0)
print(marks)

//Dictionary
var studentNumbers : [String: Int] = ["Aayush":90, "James": 80, "Peter" : 70]
print("The grades are: \(studentNumbers)")
studentNumbers ["Trevor"] = 95
studentNumbers ["Peter"] = 85
print("The updated grades are: \(studentNumbers)")

//Sets
var numbers : Set<Int> = [4,15,63,32,32,67,82]
print("The numbers are: \(numbers)")
numbers.insert(90)
numbers.remove(15)
print("The updated numbers are: \(numbers)")

//var students : [String : (age: Int, numbers: String)] = [("Aayush": 20, "A"),("James": 15,"B") ]

//Comparing two strings

let str1 = "IamAyush"
let str2 = "IamJames"
let str3 = "IamAyush"
let Str3 = "IamAyush"

print(str1 == str2)
print(str1 == str3)
print(str1 == Str3)

//Adding two strings
print(str1 + str2)

print(str1 + str2, separator: ".")

//Input value
print("What's your home city?")
let city = readLine()
print("\(city ?? "")is your home city")

////Arithmetic Operator
//
//var a = 200
//var b = 90
//var c = 80
//
//print(a+b+c)
//print(a*b-c)
//print(a%c+b)
//
//
////optionals - it gives us capability to create a variable which can have a value or it can be nil
////by default optional as nil value
//var nickname: String?
//print(nickname)
//
//
////getting out a value out of a optional variable in safe manner is optional binding
////1. If let
////2. guard let
////3. ?? - nil collecesing operator
//
