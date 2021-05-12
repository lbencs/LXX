//
//  PrivacyShieldAuthWindow.swift
//  PrivacyShield
//
//  Created by lben on 2021/1/26.
//

import UIKit
import XLComponent
private var _portraitWindow: PortraitWindow?

class PortraitWindow: UIWindow {
    private var originKeyWindow: UIWindow?
    static func isShowing() -> Bool {
        return _portraitWindow != nil
    }

    static func show(viewController: UIViewController, animated: Bool = false) {
        // 2
        _portraitWindow = PortraitWindow(frame: .screenBounds)
        _portraitWindow?.rootViewController = viewController
        _portraitWindow?.makeKeyAndVisible()
        _portraitWindow?.alpha = 1
        _portraitWindow?.isHidden = false
        // ios11系统，不设置vc的frame会横屏展示
        _portraitWindow?.rootViewController?.view.frame = .screenBounds
        if animated {
            WindowPresentationAnimator.present(window: _portraitWindow)
        }
    }

    static func hidden(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard _portraitWindow != nil else {
            return
        }
        func removeWindow() {
            _portraitWindow?.rootViewController = nil
            _portraitWindow?.alpha = 0
            _portraitWindow?.isHidden = true
            _portraitWindow = nil
            completion?()
        }
        if animated {
            WindowPresentationAnimator.dismiss(window: _portraitWindow) { removeWindow() }
        } else {
            removeWindow()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rootViewController?.view.frame = bounds
    }
}

extension CGRect {
    fileprivate static var portraitBounds: CGRect {
        return CGRect(x: 0, y: 0, width: min(CGRect.screenBounds.height, CGRect.screenBounds.width), height: max(CGRect.screenBounds.height, CGRect.screenBounds.width))
    }
}

extension CGFloat {
    fileprivate static var portraitBoundsHeight: CGFloat {
        return CGRect.portraitBounds.height
    }
}

private class WindowPresentationAnimator {
    static func present(window: UIWindow?) {
        var windowFrame: CGRect = .screenBounds
        windowFrame.origin.y = .portraitBoundsHeight
        window?.frame = windowFrame
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            window?.frame = .screenBounds
        }, completion: { _ in

        })
    }

    static func dismiss(window: UIWindow?, completion: @escaping () -> Void) {
        guard let window = window else { return }
        var windowFrame = window.frame
        windowFrame.origin.y = .screenHeight
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            window.frame = windowFrame
        }, completion: { _ in
            completion()
        })
    }
}
