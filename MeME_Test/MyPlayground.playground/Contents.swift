//: Playground - noun: a place where people can play

import Cocoa


struct Resolution {
    let width: Float
    let height: Float
    
}

var res = Resolution(width: 2, height: 4)
res

class Resolutionclass {
    let width: Float
    let height: Float
    
    init(width: Float, height: Float){
        self.width = width
        self.height = height
    }
}

let resC = Resolutionclass(width: 30, height: 50)
resC
