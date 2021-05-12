//
//  Layout.swift
//  POPDemo
//
//  Created by lben on 2021/4/13.
//

import UIKit

protocol Layout {
    mutating func layout(in rect: CGRect)
    associatedtype Content
    var contents: [Content] { get }
}

extension UIView: Layout {
    func layout(in rect: CGRect) {
        frame = rect
    }

    var contents: [UIView] {
        return subviews
    }

    typealias Content = UIView
}

struct DecoratingLayout<Child: Layout> {
    var content: Child
    var decoration: Child
    mutating func layout(in rect: CGRect) {}
}

struct CascadingLayout<Child: Layout> {
    var content: Child
    var decoration: Child
    mutating func layout(in rect: CGRect) {}
}
