//
//  SwiftWeakProxy.swift
//  Label
//
//  Created by lben on 2021/1/18.
//

#if os(iOS)
import UIKit
extension UINavigationBar {
    
    func op_set(alpha: CGFloat) {
        func op_set(view: UIView, alpha: CGFloat) {
            if let aClass = NSClassFromString("_UINavigationBarContentView"), view.isKind(of: aClass) {
                return
            }
            view.alpha = alpha
            for e in view.subviews {
                op_set(view: e, alpha: alpha)
            }
        }
        for e in subviews {
            op_set(view: e, alpha: alpha)
        }
    }
}
#endif

public
final class WeakProxy<Target: NSObjectProtocol>: NSObject {
    weak var target: Target?

    deinit {
        print("deinit ~ \(Self.self)")
    }

    public init(target: Target) {
        self.target = target
        super.init()
    }

    public override func isProxy() -> Bool {
        return true
    }

    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return target
    }

    public override class func doesNotRecognizeSelector(_ aSelector: Selector!) {
    }

    public override class func isProxy() -> Bool {
        return true
    }

    public override var hash: Int {
        guard let target = self.target else { return 0 }
        return target.hash
    }

    public override var superclass: AnyClass? {
        return target?.superclass
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let target = self.target else { return false }
        return target.isEqual(object)
    }

    public override func isKind(of aClass: AnyClass) -> Bool {
        guard let target = self.target else { return false }
        return target.isKind(of: aClass)
    }

    public override func isMember(of aClass: AnyClass) -> Bool {
        guard let target = self.target else { return false }
        return target.isMember(of: aClass)
    }

    public override func conforms(to aProtocol: Protocol) -> Bool {
        guard let target = self.target else { return false }
        return target.conforms(to: aProtocol)
    }
}
