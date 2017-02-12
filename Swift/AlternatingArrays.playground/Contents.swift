//: Playground - noun: a place where people can play

import UIKit


func CombineArrays(arr1: [String], arr2: [String]) -> [String] {
    
    var output = [String]()
    
    for index in 0..<arr1.count {
        output.append(arr1[index])
        output.append(arr2[index])
    }
    
    return output
}

CombineArrays(arr1: ["a", "b", "c"], arr2: ["bo", "ro", "me"])


//or, for type agnostic and different sized arrays:

func CombineArray2(arr1: [Any], arr2: [Any]) -> [Any] {
    
    var output = [Any]()
    
    //if arrays are different sizes, find longer one:
    let maxIndex = arr1.count >= arr2.count ? arr1.count : arr2.count
    
    for index in 0..<maxIndex {
        
        //check that index exists for each array
        if(arr1.count > index){
            output.append(arr1[index])
        }
        if(arr2.count > index){
            output.append(arr2[index])
        }
    }
    return output
}

CombineArray2(arr1: ["a", 2, "c", "d"], arr2: [20.2, "ro", "me"])