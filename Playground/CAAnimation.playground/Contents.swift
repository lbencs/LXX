//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.backgroundColor = .red
        label.frame = CGRect(x: 80, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        view.addSubview(label)
        self.view = view

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.4, animations: {
                label.transform = CGAffineTransform(translationX: -200 - label.frame.origin.x, y: 0)
            }, completion: { _ in
                label.transform = CGAffineTransform(translationX: view.frame.width + 200, y: 0)
                UIView.animate(withDuration: 0.7, animations: {
                    label.transform = CGAffineTransform.identity
                }, completion: { _ in })
            })
        }
    }
}

extension MyViewController: CAAnimationDelegate {
    class MoveAnimation: NSObject, CAAnimationDelegate {
        func animation(values: [CGFloat]) -> CAAnimation {
            let moveout = CAKeyframeAnimation()
            moveout.keyPath = "position.x"
            moveout.values = values
            moveout.duration = 0.8
            moveout.repeatCount = 1
            moveout.isAdditive = true
            moveout.fillMode = .forwards
            moveout.isRemovedOnCompletion = false
            moveout.timingFunctions = [CAMediaTimingFunction(name: .easeOut)]
            moveout.delegate = self
            return moveout
        }

        func animationDidStart(_ anim: CAAnimation) {
        }

        func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        }
    }

    func animationDidStart(_ anim: CAAnimation) {
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
