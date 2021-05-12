import UIKit

var str = "Hello, playground"

/*
 静态变量
 全局变量
 */

func address(o: UnsafeRawPointer) -> String {
    return String(format: "%018p", Int(bitPattern: o))
}

func withPoint(value: Any) -> UnsafeMutableRawPointer {
    return Unmanaged.passUnretained(value as AnyObject).toOpaque()
}

func printAddress(values: AnyObject...) {
    for value in values {
        print(Unmanaged.passUnretained(value).toOpaque())
    }
    print("-----------------------------------------")
}

func address_bitcast(o: UnsafeRawPointer) -> Int {
    return Int(bitPattern: o)
}

// func addressHeap<T: AnyObject>(o: T) -> Int {
//    return unsafeBitCast(o, Int.self)
// }

// 全局变量
var num_a: NSNumber = 0
// 常量
let num_b: NSNumber = 1

// MemoryLayout
class Duck {
    func test() {
        let num_c: Int = 2

        func printPoint(input a: Int) {
            
        }
        func test(point: UnsafePointer<Int>) {
            
        }
        printPoint(input: num_c)
        
        let point = withUnsafePointer(to: num_a) { $0 }
        
        let point3 = Unmanaged.passUnretained(num_a).toOpaque()
        
        let point2 = withUnsafePointer(to: &num_a) { Int(bitPattern: $0) }
        let point5 = address_bitcast(o: &num_a)

        print(String(format: "unm_a    %018p", Int(bitPattern: point)))
        print(String(format: "unm_a 3  %018p", Int(bitPattern: point3)))

        print(String(format: "unm_a 2  %018p", point2))
        print(String(format: "unm_a 5  %018p", point5))

        print(String(format: "unm_a %p", num_a))
    }
}

Duck().test()
