//
//  TQWindow.swift
//  UIResponser
//
//  Created by lben on 2021/3/12.
//

import UIKit

/**

 UIWindow
    - UIView_1
        - UIView_2
            _UIButton_1
            _UIButton_2
 1. 点击UIButton
 UIWindow -> UIView_1 -> UIView_2 -> _UIButton
 //    在重写touchesBegan/...的代码中没调用super.touchesBegan/...的话，就不会继续将事件传递下一个响应者了。
 //    UIControl的实例对象默认不会将事件传递给下一个响应者。但是如果你把它的target设置为nil，它会在响应者链上寻找匹配的action。
 */

class _BaseButton: UIButton {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved \(type(of: self))")
        super.touchesMoved(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled \(type(of: self))")
        super.touchesCancelled(touches, with: event)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: #lben -  Swizzle UIResponder中的方法，无法覆盖这个？ 为啥？
        print("touchesBegan \(type(of: self))")
        var next = self.next
        print("-----------start-----------")
        while let n = next {
            print("next \(type(of: n))")
            next = n.next
        }
        print("-----------end-----------")
        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded \(type(of: self))")
        super.touchesEnded(touches, with: event)
    }
}

class _BaseView: UIView {}

extension UIView {
    static func swizze() {
        Swizzle.originalSelector(#selector(hitTest(_:with:)), replace: #selector(swizzle_hitTest(_:with:)), for: classForCoder())
        Swizzle.originalSelector(#selector(point(inside:with:)), replace: #selector(swizzle_point(inside:with:)), for: classForCoder())
    }
    @objc
    func swizzle_point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("\(Self.self) - \(#function)")
        return self.swizzle_point(inside: point, with: event)
    }

    @objc
    func swizzle_hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("\(Self.self) - \(#function)")
        return self.swizzle_hitTest(point, with: event)
    }
}

extension UIResponder {
    static func swizzle() {
        Swizzle.originalSelector(#selector(touchesMoved(_:with:)), replace: #selector(swizzle_touchesMoved(_:with:)), for: classForCoder())
        Swizzle.originalSelector(#selector(touchesCancelled(_:with:)), replace: #selector(swizzle_touchesCancelled(_:with:)), for: classForCoder())
        Swizzle.originalSelector(#selector(touchesBegan(_:with:)), replace: #selector(swizzle_touchesBegan(_:with:)), for: classForCoder())
        Swizzle.originalSelector(#selector(touchesEnded(_:with:)), replace: #selector(swizzle_touchesEnded(_:with:)), for: classForCoder())
    }

    @objc func swizzle_touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(Self.self) touchesMoved \(type(of: self))")
        swizzle_touchesMoved(touches, with: event)
    }

    @objc func swizzle_touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(Self.self) touchesCancelled \(type(of: self))")
        swizzle_touchesCancelled(touches, with: event)
    }

    @objc func swizzle_touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(Self.self) touchesBegan \(type(of: self))")
        var next = self.next
        print("-----------start-----------")
        while let n = next {
            print("next \(type(of: n))")
            next = n.next
        }
        print("-----------end-----------")
        swizzle_touchesBegan(touches, with: event)
    }

    @objc func swizzle_touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(Self.self) touchesEnded \(type(of: self))")
        swizzle_touchesEnded(touches, with: event)
    }
}

class BlueButton: _BaseButton {}
class YellowButton: _BaseButton {}

class WhiteView: _BaseView {}

class TestControl: UIControl {}
class TestButton: UIButton {}
class TestSlider: UISlider {}
class TestSwitch: UISwitch {}
class TestScroll: UITableView {}
class TestGesture: UIGestureRecognizer {
}
class RedView: _BaseView {}
class BrownView: _BaseView {}
class PinkView: _BaseView {}
