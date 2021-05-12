//
//  TopNQ.swift
//  Arithmetic
//
//  Created by lben on 2021/4/25.
//

import Foundation

struct TopN {
    /**
     Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
     Output: [3,3,5,5,6,7]
     Explanation:
     Window position                Max
     ----------------
      [1  3  -1] -3  5  3  6  7       3
      1 [3  -1  -3] 5  3  6  7       3
      1  3 [-1  -3  5] 3  6  7       5
      1  3  -1 [-3  5  3] 6  7       5
      1  3  -1  -3 [5  3  6] 7       6
      1  3  -1  -3  5 [3  6  7]      7
     多种解法
     1. 遍历 -> o(n)
     2. Heap -> o(n*log(k))
     2. 双链表 -> https://zhuanlan.zhihu.com/p/34456480
     */
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        guard nums.count >= k else { return [] }
        var linkedList: [Int] = []
        var res: [Int] = []
        for (index, num) in nums.enumerated() {
            // 1. 删除比自己小的
            while let last = linkedList.last, nums[last] <= num {
                linkedList.removeLast()
            }
            // 2. 插入
            linkedList.append(index)
            // 3. 每一趟删除一个头
            if let top = linkedList.first, top <= index - k {
                linkedList.removeFirst()
            }
            // 4. 每一趟读一个数
            if index >= k - 1, let index = linkedList.first {
                res.append(nums[index])
            }
        }
        return res
    }

    // MARK: - 703. Kth Largest Element in a Stream

    class KthLargest {
        private var _items: [Int] = []
        private let _k: Int

        init(_ k: Int, _ nums: [Int]) {
            _k = k
            for e in nums { add(e) }
        }

        private func _insert(_ x: Int) {
            if _items.isEmpty {
                _items.append(x)
                return
            }
            _items.append(x)
            var index = _items.count
            while index > 1 {
                let father = _father(index)
                let brother = _brother(index)
                let swapIndex = _items[index - 1] > _items[brother - 1] ? brother : index
                if _items[father - 1] > _items[swapIndex - 1] {
                    _swap(father - 1, rhs: swapIndex - 1)
                }
                index = father
            }
        }

        private func _swap(_ lhs: Int, rhs: Int) {
            (_items[lhs], _items[rhs]) = (_items[rhs], _items[lhs])
        }

        private func _replaceTop(_ x: Int) {
            guard _items[0] < x else { return }
            _items[0] = x
            var index = 1
            while index < _k {
                let lc = index * 2
                let rc = lc + 1
                let swapIndex: Int
                if lc < _k, rc <= _k {
                    // left & right
                    swapIndex = _items[lc - 1] < _items[rc - 1] ? lc : rc
                } else if lc <= _k {
                    swapIndex = lc
                } else {
                    break
                }

                if _items[index - 1] > _items[swapIndex - 1] {
                    _swap(index - 1, rhs: swapIndex - 1)
                }
                index = swapIndex
            }
        }

        @discardableResult
        func add(_ val: Int) -> Int {
            if _items.count < _k {
                _insert(val)
            } else {
                _replaceTop(val)
            }
            return _items.first ?? 0
        }

        // index start with 1
        private func _brother(_ index: Int) -> Int {
            guard index > 1 else { fatalError() }
            return index % 2 == 0 ? _father(index) * 2 : (_father(index) * 2 + 1)
        }

        private func _father(_ index: Int) -> Int {
            guard index > 1 else { fatalError() }
            return index / 2
        }
    }

    // MARK: - 215. Kth Largest Element in an Array

    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        //
        guard nums.count >= k else { return 0 }
        var nums = nums
        var median = -1
        var left = 0
        var right = nums.count - 1
        while median != k - 1 {
            median = Sort.Bubble.Quick.partitionAfterSortOnce(left: left, right: right, compared: >, &nums)
            if median == k - 1 {
                return nums[median]
            } else if median < k - 1 {
                left = median + 1
            } else {
                right = median - 1
            }
        }
        return 0
    }

    func findKthLargest_heap(_ nums: [Int], _ k: Int) -> Int {
        guard nums.count >= k else { return 0 }
        var nums = nums
        if nums.count == 1 {
            return k == 1 ? nums[0] : 0
        }
        func father(of index: Int) -> Int {
            if index == 1 { return 0 }
            let father: Int
            if index % 2 == 0 {
                father = index / 2
            } else {
                father = (index - 1) / 2
            }
            return father
        }
        func brother(of index: Int) -> Int {
            let brother: Int
            if index % 2 == 0 {
                brother = index + 1
            } else {
                brother = index - 1
            }
            return brother
        }
        for i in 2 ... nums.count { // root = 1
            if i <= k {
                // build heap
                var child = i
                while child > 0 {
                    let f = father(of: child)
                    let b = brother(of: child)
                    guard f > 0 else { break }
                    let tmp: Int
                    if b <= i {
                        tmp = nums[b - 1] < nums[child - 1] ? b : child
                    } else {
                        tmp = child
                    }
                    if nums[f - 1] > nums[tmp - 1] {
                        (nums[f - 1], nums[tmp - 1]) = (nums[tmp - 1], nums[f - 1])
                    } else {
                        break
                    }
                    child = f
                }
            } else {
                // compare
                if nums[0] > nums[i - 1] {
                    continue
                } else {
                    // adjust heap
                    (nums[0], nums[i - 1]) = (nums[i - 1], nums[0])
                    var index = 1
                    while index < k {
                        let left = 2 * index
                        let right = 2 * index + 1
                        let child: Int
                        if left <= k, right <= k {
                            child = nums[left - 1] < nums[right - 1] ? left : right
                        } else if left <= k {
                            child = left
                        } else {
                            break
                        }
                        if nums[index - 1] > nums[child - 1] {
                            (nums[index - 1], nums[child - 1]) = (nums[child - 1], nums[index - 1])
                            index = child
                        } else {
                            break
                        }
                    }
                }
            }
        }
        return nums[0]
    }
}
