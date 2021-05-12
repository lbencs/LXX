//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

class WaterWaveView: UIView {
    var displayLink: CADisplayLink?
    lazy var firstWaveLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.white.withAlphaComponent(0.2).cgColor
        layer.lineWidth = 1.0
        return layer
    }()

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
        displayLink?.add(to: RunLoop.main, forMode: .common)
        layer.addSublayer(firstWaveLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateAnimation()
    }

    var offsetX: CGFloat = 0

    @objc private
    func updateAnimation() {
        let speed: CGFloat = 0.16 * CGFloat.pi
        offsetX += speed
        print(offsetX)

        let path = CGMutablePath()
        let wavePointY: CGFloat = 150

        let wavelength: CGFloat = frame.width
        let amplitude: CGFloat = -15

        path.move(to: .init(x: 0, y: wavePointY))
        for i in 0 ..< Int(wavelength) {
            let percent = CGFloat(i) / CGFloat(Int(wavelength))
            let angle = percent * CGFloat.pi + offsetX
            let y = amplitude * sin(angle) + wavePointY
            path.addLine(to: .init(x: percent * wavelength, y: y))
        }
        path.addLine(to: .init(x: wavelength, y: frame.height))
        path.addLine(to: .init(x: 0, y: frame.height))
        firstWaveLayer.path = path
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        let water = WaterWaveView(frame: CGRect(x: 0, y: 0, width: 375, height: 200))
        water.backgroundColor = .blue
        view.addSubview(water)
        self.view = view
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
