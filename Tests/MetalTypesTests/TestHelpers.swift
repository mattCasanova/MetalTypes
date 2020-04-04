//
//  File.swift
//  
//
//  Created by Matt Casanova on 4/3/20.
//

import UIKit

func timeIt(name: String, exec: () -> Void) {
    print(name)
    let start = CACurrentMediaTime()
    
    exec()
    
    let end = CACurrentMediaTime()
    print(end - start)
    print()
}

class Vec2 {
    var x: Float
    var y: Float
    
    init(_ x: Float = 0.0, _ y: Float = 0.0) {
        self.x = x
        self.y = y
    }

    var length: Float {
        get { sqrtf(x*x + y*y)}
    }
    
}
