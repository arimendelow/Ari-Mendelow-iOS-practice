//: Playground - noun: a place where people can play

import UIKit

var arr1 = [String]()

var arr2: [Double] = [1.1, 2, 3, 4]

var arr3 = [1, 9, 2, 2, 30]

arr1.append("hey")
arr1.append("hi")
arr1.append("hello")

arr2.append(2.314)
arr2.append(2.314)
arr2.append(2.314)

arr3.append(90)
//etc...

arr1.remove(at: 1)
arr2.remove(at: 1)
arr3.remove(at: 1)



var oddNumbers = [Int]()


for number in 1...100 {
    if(number%2 != 0) {
        oddNumbers.append(number)
    }
}
print(oddNumbers)

var sums = [Int]()

for n in oddNumbers {
    sums.append(n + 5)
}
print(sums)

var n = 0
repeat {
        print("The sum is: \(sums)")
    n+=1
} while n < sums.count






