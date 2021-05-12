//
//  TQPlayer.swift
//  PlayerDemo
//
//  Created by lben on 2021/4/12.
//

import Foundation

/**
 url -> download -> decoder -> outputStream -> InputStream -> Player

 1. 理清楚整个流程
 2. 通过协议将每一个核心步骤隔离
 3. 通过协议交换处理结果
 */

protocol Asset {}
protocol Track {}
protocol Segment {}
protocol PlayerItem {}

struct URLAsset: Asset {
    let url: URL
}

protocol VideoDecoder {
    func input(_ input: InputStream) -> OutputStream
}

// GPU解码
protocol GPUDecoder {}

// CPU解码
protocol SoftDecoder {}

protocol Player: class {
    var item: Asset { get }

    func start()
    func cancel()
    func resume()
    func pause()
}

class TQPlayer: Player {
    var item: Asset { fatalError() }

    func start() {
    }

    func cancel() {
    }

    func resume() {
    }

    func pause() {
    }
}
