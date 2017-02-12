//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//shape 1
var length = 5
var width = 10

var areaOG = length * width

func calculateArea(length: Int, width: Int) -> Int {
    let area = length * width
    return area
}

let area = calculateArea(length: 10, width: 10)

