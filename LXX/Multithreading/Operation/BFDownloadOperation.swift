//
//  BFDownloadOperation.swift
//  DomeUI
//
//  Created by lben on 2019/4/4.
//  Copyright © 2019 lben. All rights reserved.
//

import UIKit

final class BFDownloadOperation: Operation {

    private var _task: URLSessionDownloadTask?
    
    private var _isExecuting: Bool = false
    private var _isFinished: Bool = false
    private var _downloadUrl: String
    
    deinit {
        print(#function, #line, self)
    }
    
    @objc
    init(url downloadUrl: String) {
        _downloadUrl = downloadUrl
        super.init()
    }
    
    /// 监控异步执行的状态
    override var isExecuting: Bool {
        return _isExecuting
    }
    override var isFinished: Bool {
        return _isFinished
    }
    
    /// 开始执行
    override func start() {
        super.start()
        
        guard let task = _task else {
            return
        }
        _isExecuting = true
        task.resume()
    }
    
    /// 初始化任务
    override func main() {
        guard let url = URL(string: _downloadUrl) else {
            self._isFinished = true
            return
        }
    
        _task = URLSession.shared.downloadTask(with: url) {[weak self] (url, response, err) in
            print("\(String(describing: url)) --> \(String(describing: response)) -->\(String(describing: err))")
            self?._isFinished = true
            self?._isExecuting = false
        }
    }
}
