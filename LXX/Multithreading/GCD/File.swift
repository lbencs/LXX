//
//  File.swift
//  LXX
//
//  Created by lben on 2021/2/25.
//

import Foundation

class File {
}

func gcd_dispatch_io_test() {
    #if false
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true).first else { return }

        let filePath: NSString = "\(path)/test.me" as NSString
        gcd_print("file path is \(filePath)")
        guard let io = DispatchIO(type: .stream, path: filePath.utf8String!, oflag: O_RDWR | O_CREAT | O_APPEND, mode: S_IRWXU | S_IRWXG, queue: .global(), cleanupHandler: { flag in
            gcd_print(flag)
        }) else {
            gcd_print("Create io failue")
            return
        }

        guard let data = "Hello wrold!".data(using: .utf8) else { return }
        gcd_print("create data \(data)")

        let bufferPointer: UnsafeRawBufferPointer = data.withUnsafeBytes { u8ptr in
            UnsafeRawBufferPointer(u8ptr)
        }

        let dispatchData = DispatchData(bytes: bufferPointer)
//    io.write(offset: 0, data: dispatchData, queue: .global(), ioHandler: { (isSuccess, data, flag) in
//        gcd_print("write issuccess \(isSuccess). data: \(String(describing: data)), flag: \(flag)")
//    })
        io.read(offset: 0, length: .max, queue: .global(), ioHandler: { isSuccess, data, flag in
            if let data = data {
                let da = Data(copying: data)
                gcd_print("read data is \(String(data: da, encoding: .utf8) ?? "null")")
            }
            gcd_print("read issuccess \(isSuccess). data: \(String(describing: data)), flag: \(flag)")
        })
    #endif
}

extension Data {
    init(copying dd: DispatchData) {
        var result = Data(count: dd.count)
        result.withUnsafeMutableBytes { buf in
            _ = dd.copyBytes(to: buf)
        }
        self = result
    }
}
