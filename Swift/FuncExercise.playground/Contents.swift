//: Playground - noun: a place where people can play

import UIKit

func add(numOne: Int, numTwo: Int) -> Int {
    return numOne + numTwo
}

func subtract(numOne: Int, numTwo: Int) -> Int {
    return numOne - numTwo
}


func multiply(numOne: Float, numTwo: Float) -> Float {
    return numOne * numTwo
}

func divide(numOne: Double, numTwo: Double) -> Double {
    return numOne / numTwo
}

var firstNumber = 6
var secondNumber = 6

add(numOne: firstNumber, numTwo: secondNumber)
subtract(numOne: firstNumber, numTwo: secondNumber)
multiply(numOne: 6.2, numTwo: 6.2)
divide(numOne: 5.2, numTwo: 5.2)
