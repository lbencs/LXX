//
//  Condation.swift
//  MutiThreadDemo
//
//  Created by lben on 2021/4/12.
//

import Foundation
import XX

class Condation_0: Condation {
    func exe(_ block: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            print("Condation_0 => success on thread: \(Thread.current)")
            block(.success(()))
        }
    }
}

class Condation_1: Condation {
    func exe(_ block: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("Condation_1 => faile on thread: \(Thread.current)")
                block(.failure("失败"))
            }
        }
    }
}
