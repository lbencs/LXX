//
//  DemoOperation.swift
//  LockDemo
//
//  Created by lbencs on 05/12/2017.
//  Copyright © 2017 lbencs. All rights reserved.
//

import Foundation
//http://blog.leichunfeng.com/blog/2015/07/29/ios-concurrency-programming-operation-queues/
/**
 Operation
 BlockOperation
 OperationQueue
 Custom Concurrent Operation
 Custom NonConcurrent Operation
 addDependency
 异步Operation并不会导致OperationQueue中MaxConcurrentThread增加
 
 GCD vs Operation Queue
 1. GCD更轻量级
 2. Operation在GCD之上建立的面向对象的解决方案
 3. Opertion更灵活、支持更多功能，比如：cancel、suspend、resume等
 4. GCD使用更方便、更简单
 
 
 Thread
 1. GCD也好、Operation也好，都是基于运行到具体的Thread
 2. 更像是对Thread的一个管理工具
 
 ###对比GCD、Operation
 ###Operation
 - Operation
 - ConcurrentOperation  //同步
 - NonConcurrentOperation //异步
 - start() or add to Queue Since so much of the benefit of NSOperation is derived from NSOperationQueue, it’s almost always preferable to add an operation to a queue rather than invoke start directly.
 - ready → executing → finished
 
 - OperationQueue
 - maxConcurrentOperationCount 最大同时支持多个Operation运行
 - maxConcurrentOperationCount = 1,
 - 一次只有一个Operation，但是并不一定在同一个Thread执行
 - 执行顺序不一定严格按照FIFO，会受其他条件影响（isRead、优先级），而DispatchQueue中的Serial Queue严格执行FIFO
 - First in First Out的执行顺序
 
 ###GCD
 - Concurrent Dispatch Queue
 - Serial Dispatch Queue
 
 //无序执行
 #### Concurrent Queue + Concurrent Operation
 #### Concurrent Queue + Non Concurrent Operation
 #### Serial Queue + Concurrent Operation
 //顺序执行
 #### Serial Queue + Non Concurrent Operation
 
 
 ####GCD，缺少Operation，所以其更简单、更轻量级
 - DispatchQueue
 
 */
/*
 异步Operation vs 同步Operation
 (synchronous communication/ asynchronous communication)
 
 关注点在于消息通讯的机制
 
 同步：调用者 等待 调用执行过程，直到返回结果。当出现资源占用，需要等待时，会一直处于等待状态。
 异步：调用者 调用以后，不等待执行结果返回，结果返回后，回调提前设置的回调方法
 
 队列：一次只执行一个，按照顺序执行
 并行：一次执行多个，按顺序执行
 
 
 OperationQueue
 只有当需要手动去start（），且需要进程是异步的情况下，
 才需要去自己实现一套异步的Operation
 addOperation(:)方法添加到Queue中时，会自动创建Thread来处理这个Operation。
 所以大部分情况下，我们可以通过Queue来实现异步，而不需要去手动实现一个异步的Operation。
 1. 开线程去同步执行 vs 开线程异步执行
 2.
 */
func exampleOfNonConcurrentOperation() {
    
    example(of: "example Of Non Concurrent Operation") {
        
        let operation_1 = NonConcurrentOperation()
        operation_1.name = "operation_1"
        operation_1.completionBlock = {
            print("operation_1 in \(Thread.current)")
        }
        let operation_2 = NonConcurrentOperation()
        operation_2.name = "operation_2"
        operation_2.completionBlock = {
            print("operation_2 in \(Thread.current)")
        }
        let operation_3 = NonConcurrentOperation()
        operation_3.name = "operation_3"
        operation_3.completionBlock = {
            print("operation_3 in \(Thread.current)")
        }
        
        let b_operation_1 = BlockOperation(block: {
            //            sleep(4)
        })
        b_operation_1.queuePriority = .veryLow
        b_operation_1.completionBlock = {
            print("b_operation_1 in \(Thread.current)")
        }
        
        let c_operation_1 = ConcurrentOperation()
        c_operation_1.name = "c_operation_1"
        c_operation_1.queuePriority = .veryHigh
        c_operation_1.completionBlock = {
            print("c_operation_1 in \(Thread.current)")
        }
        let c_operation_2 = ConcurrentOperation()
        c_operation_2.name = "c_operation_2"
        c_operation_2.completionBlock = {
            print("c_operation_2 in \(Thread.current)")
        }
        let c_operation_3 = ConcurrentOperation()
        c_operation_3.name = "c_operation_3"
        c_operation_3.completionBlock = {
            print("c_operation_3 in \(Thread.current)")
        }
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        
        /**
         maxConcurrentOperationCount = 1
         - 一次只执行一个Operation，直到Operation完成，不管Operation是异步还是同步
         
         maxConcurrentOperationCount > 1
         - 一次执行多个
         */
        //        print("---->")
        //        c_operation_3.start()
        //        print("---->")
        
        queue.addOperation(c_operation_1)
        
        queue.addOperations([b_operation_1], waitUntilFinished: true)
        queue.addOperation(c_operation_2)
        queue.addOperation(c_operation_3)
        //        queue.addOperation(b_operation_1)
        queue.addOperation(operation_1)
        queue.addOperation(operation_2)
        queue.addOperation(operation_3)
        
        
        
    }
    
}
func exampleOfConcurrentOperation() {
    
    example(of: "example Of ConcurrentOperation") {
        
        /**
         1. 会在三个不同的Thread种执行
         */
        let operation_1 = ConcurrentOperation()
        operation_1.completionBlock = {
            print("operation_1")
        }
        let operation_2 = ConcurrentOperation()
        operation_2.completionBlock = {
            print("operation_2")
        }
        let operation_3 = ConcurrentOperation()
        operation_3.completionBlock = {
            print("operation_3")
        }
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperation(operation_1)
        queue.addOperation(operation_2)
        queue.addOperation(operation_3)
    }
    
}

func exampleOfNSOperation() {
    
    example(of: "NSOperation") {
        let operationQueue = OperationQueue()
        //maxConcurrentOperationCount == 1
        //按添加顺序执行
        operationQueue.maxConcurrentOperationCount = 1
        for i in 0...10 {
            //            operationQueue.addOperation({
            //                print(i)
            //            })
            //            let nov = InvocationOperation()
            
            //            operationQueue.addOperation(DownloadOperation(url:"http://downloadurl_\(i)"))
        }
        /// BlockOperation
        /// 可以添加多个Block, 到一个Concurrent Dispatch中
        /// Block全部执行完，Operation才会结束。 可以用来track一串无序Block执行完成。
        /// 合并多个网络请求的数据
        let oa = MyBlockOperation(block: {
            print("---> oa")
        })
        oa.addExecutionBlock {
            for _ in 0...9000 {}
            print("---> oa 2")
        }
        oa.addExecutionBlock {
            print("---> oa 3")
        }
        let ob = MyBlockOperation(block: {
            print("---> ob")
        })
        let oc = MyBlockOperation(block: {
            print("---> oc")
        })
        let od = MyBlockOperation(block: {
            print("---> od")
        })
        let oe = MyBlockOperation(block: {
            print("---> oe")
        })
        /*
         *  当Operation行程循环引用时，其所依赖的Operation也无法释放
         */
        oa.addDependency(ob)
        oa.addDependency(oc)
        ob.addDependency(od)
        oc.addDependency(oe)
        //        oe.addDependency(oa)
        operationQueue.addOperation(oa)
        operationQueue.addOperation(ob)
        operationQueue.addOperation(oc)
        operationQueue.addOperation(od)
        operationQueue.addOperation(oe)
    }
}

enum Download {
    case download(with: NSURL)
    case success
    case failue(error: Error)
}
class MyBlockOperation: BlockOperation {
    deinit {
        print("deinit: \(self)")
    }
}
/**
 
 1. subclass Operaion directly.
 2. class提供了大量的基础结构来支持大部分附属功能以及KVO通知等
 3. implementing a concurrent operation or a nonconcurren operation
 
 #nonconcurrent
 > Defining a nonconcurrent operation is much simpler than defining a concurrent operation. For a nonconcurrent operation, all you have to do is perform your main task and respond appropriately to cancellation events; the existing class infrastructure does all of the other work for you. For a concurrent operation, you must replace some of the existing infrastructure with your custom code. The following sections show you how to implement both types of object.
 
 List to finish
 - A custom initialization method
 - main to preform your task
 
 implement additional methods as need
 such as the following
 - custom methods that plan to call in main method
 - Accessor methods to setting/getting data
 - method of NSCoding protocol to support archive/unarchive the operation object
 
 
 #Responding to Cancellation Events
 - 一个Operation执行以后，随时有可能被cancel
 - use isCancelled to judege to continue or cancel
 
 isCancelled is lightweight method that can called frequently without any
 significant preformmance.
 
 uset it
 - Immediately before you preform any actual work
 - At least once during each iteration of loop, or more frequently if each iteration is relatively long
 - Ant any points in your code where it would be relatively easy to abort the operation
 */
class NonConcurrentOperation: Operation {
    
    override func main() {
        //Custom What to do
        
        //如果cancel掉了，就返回，不执行函数体
        guard !isCancelled else { return }
        
        //        for i in 0...9000000 {
        //            _ = "\(i)"
        //        }
        //无需触发状态属性
        //无需调用completionBlock
        
        //        print("NonConcurrentOperation: \(self) in thread: \(Thread.current)")
    }
}

/**
 
 #对于KVO的支持
 Maintaining KVO Compliance
 - isCancelled
 - isConcurrent
 - isExecuting
 - isFinished
 - isReady
 - dependencies
 - queuePriority
 - completionBlock
 */

class ConcurrentOperation: Operation {
    
    //是否已经完成
    private var _isFinished: Bool = false
    
    //是否正在执行
    private var _isExecuting: Bool = false
    
    override init() {
        super.init()
        
    }
    override func start() {
        //replace the default behavior with their own custom implementation.
        //cancel 掉
        guard !isCancelled else {
            _isFinished = true
            return
        }
        
        //防止重复执行
        guard !isExecuting else { return }
        
        //开始执行
        self.willChangeValue(forKey: "isExecuting")
        //采用异步执行main函数
        //        Thread.detachNewThreadSelector(#selector(main), toTarget: self, with: nil)
        DispatchQueue.global().async {
            self.main()
        }
        _isExecuting = true
        self.didChangeValue(forKey: "isExecuting")
    }
    override func main() {
        
        //        sleep(3)
        //        for i in 0...9000000 {
        //            _ = "\(i)"
        //        }
        
        //        print("ConcurrentOperation: \(self) in thread: \(Thread.current)")
        
        self.willChangeValue(forKey: "isFinished")
        self.willChangeValue(forKey: "isExecuting")
        
        _isFinished = true
        _isExecuting = false
        
        self.didChangeValue(forKey: "isExecuting")
        self.didChangeValue(forKey: "isFinished")
        
        //finished
    }
    
    //并行Operation
    override var isAsynchronous: Bool {
        return true
    }
    override var isConcurrent: Bool {
        return true
    }
    override var isFinished: Bool {
        return _isFinished
    }
    override var isExecuting: Bool {
        return _isExecuting
    }
}

//
//以enum的形式，将不同的分支通过枚举来变量
//将层级关系更清晰的呈现在调用者面前
enum Result {
    case Success(response: Any?)
    case Failue(error: Error)
    case Cancel
}

class DownloadOperation: Operation {
    
    let url: String
    init(url: String) {
        self.url = url
        super.init()
    }
    
    override func main() {
        super.main()
        //自定义线程操作
        
        
        guard isCancelled else {
            print("操作取消")
            return
        }
        
        OperationQueue.main.addOperation {
            
        }
    }
    
    
    deinit {
        print("deinit: \(self) with url:\(url)")
    }
}



func exampleOfThread() {
    example(of: "Thread") {
        /**
         Thread
         #作用
         1. 创建子线程，处理某些任务
         2. 可以控制线程的优先级
         3. 无法绝对控制线程的执行顺序
         */
        var count = 1
        for i in 0...10 {
            let thread = Thread {
                print("----------start-\(i)-----------------")
                count = count + i
                print(Thread.current, Thread.current.threadPriority, count)
                print("----------end-\(i)-----------------")
            }
            thread.name = "子线程:\(i)"
            thread.threadPriority = Double(i)/10.0
            thread.start()
        }
    }
}

struct DownloadThread {
    static func download(url: URL, _ finished: @escaping () -> ()) {
        let thread = Thread {
            Thread.sleep(forTimeInterval: 5)
            finished()
        }
        thread.start()
    }
}
