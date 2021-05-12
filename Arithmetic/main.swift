//
//  main.swift
//  Arithmetic
//
//  Created by lben on 2021/4/16.
//

import AppKit
import Foundation

struct UITree {
    class Queue<T> {
        class Node<T> {
            deinit { print("deinit ~ \(Self.self)") }
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

    static func testQueue() {
        let queue = Queue<Int>()
        for i in 0 ... 10 {
            queue.push(i)
        }
        while let value = queue.pop() {
            print("--> \(value)")
        }
    }

    static func printUITree(view: NSView) {
        let queue = Queue<NSView>()
        queue.push(view)
        while let view = queue.pop() {
            print("\(view)")
            for view in view.subviews {
                queue.push(view)
            }
        }
    }
}

// UITree.testQueue()

struct BigNumberAdd {
    // 两个大数相加(用两个list表示大数)
    // 192081231242
    // 192039201
    static func add(left: [Int], right: [Int]) -> [Int] {
        var long = left
        var short = right
        if long.count < short.count {
            long = right
            short = left
        }

        var tmp: Int = 0
        for i in 0 ..< long.count {
            var sum = long[i] + tmp
            if short.count > i {
                sum += short[i]
            }
            long[i] = sum % 10
            tmp = sum / 10
            if i >= short.count && tmp == 0 {
                return long
            }
        }
        if tmp > 0 {
            long.append(tmp)
        }
        return long
    }

    static func test() {
        print(add(left: [1, 8, 9, 7, 6, 4, 3, 2, 2, 4, 5], right: [1, 8, 9, 7, 6, 4, 3, 2, 2, 4, 5]))
        print(add(left: [1, 8, 9, 7, 6, 4, 3, 2, 2, 4, 5], right: [6, 4, 3, 2, 5, 6]))
    } // [6, 4, 3, 2, 5, 6]
}

struct MergeSortedArray {
    static func merge(left: [Int], right: [Int]) -> [Int] {
        var res: [Int] = []

        var left_index: Int = 0
        var right_index: Int = 0

        while left_index < left.count, right_index < right.count {
            if left[left_index] < right[right_index] {
                res.append(left[left_index])
                left_index += 1
            } else {
                res.append(right[right_index])
                right_index += 1
            }
        }
        while left_index < left.count {
            res.append(left[left_index])
            left_index += 1
        }
        while right_index < right.count {
            res.append(right[right_index])
            right_index += 1
        }
        return res
    }

    static func test() {
        print(merge(left: [1, 3, 5, 7, 9, 10, 24, 98], right: [0, 2, 4, 6, 8, 11, 55, 109, 111, 123]))
    }
}

struct MedianNumberOfArray {
//    无序数组的中位数，数组长度为n
    func findMedianArrays(on array: [Int]) -> Int {
        guard array.isEmpty else { fatalError() }
        // 1. 排序，找中间数
        // 2. 模拟排序过程找中位数
        // 快排思想
        fatalError()
    }

    static func test() {
//        print(Solution().findMedianSortedArrays([1, 3], [2]))
//        print(Solution().findMedianSortedArrays([1, 2], [3, 4]))
//        print(Solution().findMedianSortedArrays([0, 0], [0, 0]))
//        print(Solution().findMedianSortedArrays([], [1]))
    }
}

struct MapData {
    // 给定一个非空整数数组，取值范围[0,100]，除了某个元素出现奇数次以外
    // 其余每个元素均出现次数为偶数。找出那个出现次数为奇数次的元素。

    static func findOddNumber(in array: [Int]) -> Int {
        var map: [Int: Int] = [:]
        for i in array {
            let value = map[i] ?? 0
            if (value + 1) % 2 == 0 {
                map.removeValue(forKey: i)
            } else {
                map[i] = value + 1
            }
        }
        return map.first!.key
    }

    static func test() {
        print(findOddNumber(in: [1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1]))
    }
}

// MapData.test()

struct LinkListTest {
    static func createLinkList() -> LinkedList<Int> {
        let linkList = LinkedList<Int>()
        for i in 0 ... 15 {
            linkList.insertTo(head: i)
        }
        return linkList
    }

    static func linkList() {
        let linkList = createLinkList()
        print("\(linkList)")
        linkList.reverse()
        print("\(linkList)")
    }

    static func 倒数第k个数() {
        // 求链表倒数第k个元素
        // 1. 单列表
        // 2. 双向链表
        let linkList = createLinkList()
        // 1 -> 2 -> 3 -> 4 -> 5
        // 1. 快慢指针
        // 2. 倒插法
        // 3.
        print(#function)
        print(linkList)
        print(linkList.findKthFromEnd(7) ?? -1)
    }
}

// LinkListTest.linkList()
// LinkListTest.倒数第k个数()

// print([1,6,7,3,9,0,8,28,10,89,2])
// print(HeapSort.sort(HeapSort.build([1,6,7,3,9,0,8,28,10,89,2])))
// print(QuickSort.sort([1,6,7,3,9,0,8,28,10,89,2]))

// Recursion

// var start = Date()
// print(Recursion.sum(from: 1, to: 100))
// print("sum -> \(Date().timeIntervalSince(start) * 1000)")
// start = Date()
// print(Recursion.sum2(from: 1, to: 100))
// print("sum2 -> \(Date().timeIntervalSince(start) * 1000)")
//
// let nth = 26
// print(Recursion.power(nth: nth, for: 5))
// print("power -> \(Date().timeIntervalSince(start) * 1000)")
// start = Date()
// print(Recursion.power2(nth: nth, for: 5))
// print("power2 -> \(Date().timeIntervalSince(start) * 1000)")
// start = Date()
// print(Recursion.power3(nth: nth, for: 5))
// print("power3 -> \(Date().timeIntervalSince(start) * 1000)")
// start = Date()
// var result: Int = 1
// Recursion.tailPower(nth: nth, for: 5, res: &result)
// print(result)
// print("power5 -> \(Date().timeIntervalSince(start) * 1000)")
//
//// ??栈的速度快
// start = Date()
// print(Recursion.power4(nth: nth, for: 5))
// print("power4 -> \(Date().timeIntervalSince(start) * 1000)")

// print(StringQ.RemoveSpace.run(Array(" a bc de  f")))
// print([1, 6, 7, 3, 9, 0, 8, 28, 10, 89, 2])
// print(Sort.Bubble.sort([1, 6, 7, 3, 9, 0, 8, 28, 10, 89, 2]))
// print(Sort.Select.sort([1, 6, 7, 3, 9, 0, 8, 28, 10, 89, 2]))
// print(Sort.Insert.sort([1, 6, 7, 3, 9, 0, 8, 28, 10, 89, 2]))
// print(StringQ.reversed("abcdefg"))

// let tree = BinaryTree(0 ... 10)
// print("pre-order: \(tree.preorderTraversal())")
// print("pre-order: \(tree.dlr())")
// print("post-order: \(tree.postorderTraversal())")
// print("post-order: \(tree.lrd())")
// print("in-order: \(tree.inorderTraversal())")
// print("in-order: \(tree.ldr())")
// print("sequence: \(tree.sequenceTraversal())")
// print("sequence: \(tree.sequence())")
// tree.invert()
// print("sequence: \(tree.sequence())")

// let testTree = BinaryTree([4, 2, 7, 1, 3, 6, 9])
// testTree.invert()
// print("test tree: \(testTree.sequence())")
// print(BinaryTree.printTree(testTree.root))

let root = BinaryTree<Int>.Node(value: 0)
let n1 = BinaryTree<Int>.Node(value: 1)
let n2 = BinaryTree<Int>.Node(value: 2)
let n3 = BinaryTree<Int>.Node(value: 3)
let n4 = BinaryTree<Int>.Node(value: 4)
let n5 = BinaryTree<Int>.Node(value: 5)
let n6 = BinaryTree<Int>.Node(value: 6)
let n7 = BinaryTree<Int>.Node(value: 7)
let n8 = BinaryTree<Int>.Node(value: 8)
let n9 = BinaryTree<Int>.Node(value: 9)
let n10 = BinaryTree<Int>.Node(value: 10)
let n11 = BinaryTree<Int>.Node(value: 11)

n1.left = n2
n1.right = n3
n10.left = n11
n9.left = n10
n3.left = n9
n3.right = n4
root.left = n1
n5.left = n6
n5.right = n7
n7.right = n8
root.right = n5

let bitTree = BinaryTree(root: root)

// print(bitTree.sequence())
//print("tree height: \(bitTree.height())")
//print("tree height: \(bitTree.height2())")
//print("tree height: \(bitTree.height3())")
//print("tree height: \(bitTree.height4())")
//print("tree height: \(bitTree.height5())")

// print(bitTree.sequence())
// print(BinaryTree.printTree(bitTree.root))

let smallTree: BinaryTree<Int> = {
    let node1 = BinaryTree<Int>.TreeNode(value: 1)
    let node2 = BinaryTree<Int>.TreeNode(value: 2)
    let node3 = BinaryTree<Int>.TreeNode(value: 3)
    let node4 = BinaryTree<Int>.TreeNode(value: 4)
    node1.left = node2
    node1.right = node3
    node2.right = node4
    return BinaryTree(root: node1)
}()

// print(smallTree.sequence())
// print(BinaryTree.printTree(smallTree.root))

// print("\([3, 9, 308, 30, 34, 5, 91]) => \(ArrayQ.maxNumber(with: [3, 9, 308, 30, 34, 5, 91]))")
// print("\([3, 35, 2]) => \(ArrayQ.maxNumber(with: [3, 35, 2]))")

// print([3, 9, 308, 30, 34, 5, 91].sorted(by: >))
// print([3, 9, 308, 30, 34, 5, 91].sorted(by: >=))
// print("\([3, 9, 308, 30, 34, 5, 91]) => \(Sort.Bubble.Quick.Solution().sortArray([3, 9, 308, 30, 34, 5, 91]))")
// print("\([3, 9, 308, 30, 34, 5, 91]) => \(Sort.Bubble.Quick.Solution().sort([3, 9, 308, 30, 34, 5, 91], compared: >=))")
// print("\([3, 35, 2]) => \(Sort.Bubble.Quick.Solution().sort([3, 35, 2], compared: >))")
// print("\([3, 35, 2]) => \(Sort.Bubble.Quick.Solution().sort([3, 35, 2], compared: >=))")

// print("[3, 2, 1, 5, 6, 4] success -> 5: res = \(ArrayQ().findKthLargest([3, 2, 1, 5, 6, 4], 2))")
// print("[1] success -> 1: res = \(ArrayQ().findKthLargest([1], 1))")
// print("[-1,2,0] success -> 0: res = \(ArrayQ().findKthLargest([-1,2,0], 2))")
// print("[7,6,5,4,3,2,1] success -> 3: res = \(ArrayQ().findKthLargest([7,6,5,4,3,2,1], 5))")

// print(StringQ.Solution().countSegments("Hello, my name is John"))
// print(StringQ.Solution().countSegments("Hello, my name is John"))

// print(StringQ.Solution().isInterleave("aabcc", "dbbca", "aadbbcbcac"))
// print(DPQ.Solution().uniquePaths(3, 7))
// print(DPQ.Solution().uniquePaths(3, 2))

// print(DPQ.Solution().uniquePathsWithObstacles([[0, 0, 0], [0, 1, 0], [0, 0, 0]]))
// print(DPQ.Solution().uniquePathsWithObstacles([[0, 1], [0, 0]]))

// print(DPQ.Solution().lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]))
// print(DPQ.Solution().lengthOfLIS([1, 3, 6, 7, 9, 4, 10, 5, 6]))
// print(DPQ.Solution().longestCommonSubsequence("bl", "yby"))
// print(DPQ.Solution().longestCommonSubsequence("bsbininm", "jmjkbkjkv"))

// print(Sort.Heap.build([1,6,7,3,9,0,8,28,10,89,2]))
// var h = Heap<Int>(nodes: [1,6,7,3,9,0,8,28,10,89,2], sort: >)
// h.insert(90)
// h.insert(18)
// h.insert(0)
// h.replace(index: 0, value: 100)
// while let v = h.remove() {
//    print(v)
// }

// print(MergeQ().mergeKLists([.init(1)])?.val)

QRunning()
BinarySearchTreeTest()
StringQ.runTest()
