//
//  Three+Func.swift
//  Arithmetic
//
//  Created by lben on 2021/4/21.
//

import Foundation

extension BinaryTree {
    struct _NodeWapper<NodeValue> {
        let level: Int
        let index: Int
        let node: NodeValue
    }

    static func printTree(_ root: TreeNode?) -> [[String]] {
        guard let root = root else { return [] }
        var res: [[_NodeWapper<TreeNode>]] = []
        var list: [_NodeWapper<TreeNode>] = [_NodeWapper(level: 1, index: 1, node: root)]
        while !list.isEmpty {
            let wapper = list.removeFirst()
            var levelArr: [_NodeWapper<TreeNode>]
            if res.count > wapper.level - 1 {
                levelArr = res[wapper.level - 1]
            } else {
                levelArr = []
                res.append(levelArr)
            }
            levelArr.insert(wapper, at: 0)
            res[wapper.level - 1] = levelArr

            if let left = wapper.node.left {
                let wap = _NodeWapper(level: wapper.level + 1, index: wapper.index * 2, node: left)
                list.insert(wap, at: 0)
            }

            if let right = wapper.node.right {
                let wap = _NodeWapper(level: wapper.level + 1, index: wapper.index * 2 + 1, node: right)
                list.insert(wap, at: 0)
            }
        }
        func intPow(_ a: Int, _ b: Int) -> Int {
            return Int(pow(Float(a), Float(b)))
        }

        func numbers(in level: Int) -> Int {
            return Int(pow(Float(2), Float(level - 1)))
        }

        func cloumnIndex(with index: Int, level: Int) -> Int {
            return index - intPow(2, level - 1)
        }

        let height = res.count
        let cloumns = intPow(2, res.count) - 1
        let placeHolder = (0 ..< cloumns).map({ _ in "" })

        return res.enumerated().map { (arg) -> [String] in
            var res = placeHolder
            for wap in arg.element {
                let level = wap.level
                let index = wap.index
                if level == 1 {
                    res[cloumns / 2] = "\(wap.node.value)"
                } else {
                    let cloum = cloumnIndex(with: index, level: level)
                    let maxCloum = numbers(in: level)
                    // 2 ^ (heigth - level) = start
                    let startIndex = intPow(2, height - level) - 1

                    let space = (cloumns - startIndex * 2 - maxCloum) / (maxCloum - 1)
                    let subIndex = startIndex + space * cloum + cloum
                    res[subIndex] = "\(wap.node.value)"
                }
            }
            return res
        }
    }
}
