//
//  ViewController.swift
//  LXX
//
//  Created by lben on 2021/1/19.
//

import UIKit
import XX

// MARK: - LoopLabel

// import LoopLabel
// class ViewController: UIViewController {
//    struct TestItem: LoopItem {
//        let title: String
//    }
//
//    let label = LoopLabel()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .black
//        label.frame = .init(x: 20, y: 100, width: 200, height: 40)
//        view.addSubview(label)
//        label.backgroundColor = .black
//        label.onDidChangedTo { item, _ in
//            print("Did show item: \(item)")
//        }
//        .onDidSelected { item, _ in
//            print("Did selected item: \(item)")
//        }
//        .start(with: [TestItem(title: "hello world!"), TestItem(title: "hello my baby.")])
//    }
// }

// MARK: - GuestureLock

class DomeClass {
//    static var `self`: DomeClass.Type {
//        return self
//    }
//    var `self`: Self {
//        return self
//    }
    static func `self`() -> DomeClass.Type {
        return self
    }

    func `self`() -> Self {
        return self
    }

    static func test() {
        print(self)
    }

    var object: NSObject = {
        let cla = NSObject()
        print(self)
        return cla
    }()
}

class Runnter: Runnable {
    deinit {
        print("deinit ~ \(Self.self)")
    }

    func run() {
        print("Runner")
    }
}

struct UITree {
    class Queue<T> {
        class Node<T> {
            var next: Node<T>?
            let value: T
            init(value: T) {
                self.value = value
            }
        }

        var head: Node<T>?

        func push(_ value: T) {
            if head == nil {
                head = Node<T>(value: value)
                return
            }
            let node = Node<T>(value: value)
            node.next = head
            head = node
        }

        func pop() -> T? {
            let value = head?.value
            head = head?.next
            return value
        }
    }

    static func printUITree(view: UIView) {
        let queue = Queue<UIView>()
        queue.push(view)
        while let view = queue.pop() {
            print("------->\(view)")
            for view in view.subviews {
                queue.push(view)
            }
        }
    }
}

import GuestureLock
class ViewController: UIViewController {
    let cal = DomeClass()
    var targetVC: UIViewController = {
        let vc = UIViewController()
        print(self)
        return vc
    }()

    var lockView: GestureLockView!
    override func viewDidLoad() {
        super.viewDidLoad()

        DomeClass.test()
        let points = (0 ..< 9).map({ TouchPointView(value: $0) })
        lockView = GestureLockView(gridView: GridView(touchPoints: points))
        lockView.frame = CGRect(x: 20, y: 100, width: 300, height: 300)
        view.addSubview(lockView)
        test()
        let thread = Thread(runner: Runnter())
        thread.start()
        thread.xx_deallocBlock {
            print("xx")
        }
        UITree.printUITree(view: self.view)
    }

    var arr: [Int] = []
    func test() {
    }
}

// MARK: - DuckTyping

// class ViewController: UIViewController {
//    var timer: Timer?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        DuckTyping.test()
//    }
// }
