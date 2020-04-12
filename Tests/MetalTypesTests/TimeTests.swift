
import XCTest
@testable import MetalTypes

import simd

final class SpeedTests: XCTestCase {
    func test() {
        let max = 30_000_000
        
        
        timeIt(name: "GL") {
            let vector1 = Vector2D(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            let vector2 = Vector2D(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            
            for _ in 0..<max {
                let v = vector1.projectOn(to: vector2)
                
                if (v.length == vector1.length) {
                    print("Same")
                }
            }
        }
        
        timeIt(name: "SIMD") {
            let first = Float2(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            let second = Float2(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            
            for _ in 0..<max {
                let v = first.projectOn(to: second)
                
                if (v.length == first.length) {
                    print("Same")
                }
            }
        }
        
        
        timeIt(name: "SIMD Real") {
            let first = simd_float2(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            let second = simd_float2(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            
            for _ in 0..<max {
                let v = simd_project(first, second)
                
                if (simd_length(v) == simd_length(first)) {
                    print("Same")
                }
            }
        }
        
        timeIt(name: "SIMD Ext") {
            let first = simd_float2(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            let second = simd_float2(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            
            for _ in 0..<max {
                let v = first.project(vec: second)
                
                if (v.length == first.length) {
                    print("Same")
                }
            }
        }
        
        timeIt(name: "SIMD Vec") {
            let first = Vec(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            let second = Vec(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            
            for _ in 0..<max {
                let v = first.project(vec: second)
                
                if (v.length == first.length) {
                    print("Same")
                }
            }
        }
        
    }
    
    static var allTests = [
        ("test", test),
    ]
}

class Vec {
    var v = simd_float2()
    
    init() {
        
    }
    
    init(x: Float, y: Float) {
        v.x = x
        v.y = y
    }
    
    var length: Float { get { simd_length(v) } }
    
    func project(vec: Vec) -> Vec {
        let n = simd_project(v, vec.v)
        return Vec(x: n.x, y: n.y)
    }
    
}

extension simd_float2 {
    var length: Float { get { simd_length(self) } }
    
    func project(vec: simd_float2) -> simd_float2 {
        return simd_project(self, vec)
    }
    
}
