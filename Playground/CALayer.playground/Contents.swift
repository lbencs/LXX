//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

class XXXCALayerView: UIView {
}

class MyViewController: UIViewController {
    override func loadView() {
        let view = XXXCALayerView()
        view.backgroundColor = .white
        self.view = view

        let blueLayer = CALayer()
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.backgroundColor = UIColor.blue.cgColor

        blueLayer.delegate = self
        view.layer.addSublayer(blueLayer)
        
        
        blueLayer.display()
    }
}

extension MyViewController: CALayerDelegate {
    //1. 设置寄宿图
//    func display(_ layer: CALayer) {
//        print(#function)
//    }

    //2. 绘制寄宿图
    func draw(_ layer: CALayer, in ctx: CGContext) {
        print(#function)
        // draw a thick red circle
        ctx.setLineWidth(10.0)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.strokeEllipse(in: layer.bounds)
    }

    func layerWillDraw(_ layer: CALayer) {
        print(#function)
    }

    func layoutSublayers(of layer: CALayer) {
        print(#function)
    }

    func action(for layer: CALayer, forKey event: String) -> CAAction? {
        print(#function, "===> \(event)")
//        CABasicAnimation()
        return nil
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
