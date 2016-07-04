//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var myFirstVar = "hello"
myFirstVar = "Hi"
myFirstVar = "newValue"

let number = 10
let variable:String = "something"
let variable2 = "string" as String
myFirstVar = "\(number)"

var something:Int = 10

//Array
var myArray = [10, 7 , 9, 5]
var myArrayString = ["one", "two", "three", "four", "five"]


myArray = NSArray(array: [2,5,6,7]) as! [Int]

var anotherArray:NSArray = NSArray()
anotherArray = ["monday","Tuesday","Wendsday"]


//String -> NSString
// NSNumber
// NSArray
// Int , Bool

var arrayColors = [UIColor.blackColor(), UIColor.whiteColor(), UIColor.purpleColor()]

//For

for value in arrayColors{
    print(value)
}


//Dictionary
                    //key      //value
var myDictionary = ["one":"value1",
                    "two":"value2",
                    "Three":"value3"]

var otherDictionary = ["name1":"Héctor",
                        "phone": ["work": "3123131232",
                                  "home":"312312222"],
                        "myDictionary": myDictionary]


if let option = otherDictionary["phone"] as? NSDictionary
{
    if let home = option.objectForKey("home") as? String
    {
        print(home)
    }
}

print((otherDictionary["phone"]!["home"]))

print(otherDictionary.objectForKey("phone")!.objectForKey("home")!)

print(otherDictionary.objectForKey("name"))






















