//
//  PasswordField.swift
//  PrivacyShield
//
//  Created by lben on 2021/1/26.
//

import UIKit
import XX
// public extension Reactive where Base: PasswordField {
//    var digits: ControlProperty<[Int]> {
//        return base._textField.rx.controlProperty(editingEvents: .editingChanged) { [weak base] (_) -> [Int] in
//            base?.digits ?? []
//        } setter: { [weak base] textField, newValue in
//            textField.text = newValue.stringValue
//            base?.digits = newValue
//        }
//    }
// }

public final
class PasswordField: UIView {
    fileprivate var _textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .clear
        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .default
        return textField
    }()

    private var _textFieldDelegate = _TextFieldDelegate()

    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        return _textField.becomeFirstResponder()
    }

    @discardableResult
    override public func resignFirstResponder() -> Bool {
        return _textField.resignFirstResponder()
    }

    override public func reloadInputViews() {
        _textField.reloadInputViews()
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first, frame.contains(point.location(in: superview)) {
            becomeFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }

    override public var frame: CGRect {
        didSet { setNeedsDisplay() }
    }

    public enum Style {
        case point
        case frame(lineColor: UIColor, pointColor: UIColor)
    }

    public var style: Style = .frame(lineColor: .hexString("#949BA5"), pointColor: .hexString("#26292D")) {
        didSet { setNeedsDisplay() }
    }

    public var digits: [Int] = [] {
        didSet {
            _textField.text = digits.reduce("", { res, ele in
                var result = res ?? ""
                result.append("\(ele)")
                return result
            })
            setNeedsDisplay()
        }
    }

    public var numberOfDigits: Int = 4 {
        didSet { setNeedsDisplay() }
    }

    public init() {
        super.init(frame: .zero)
        makeup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let width = rect.width - Constants.leftMerge - Constants.rightMerge
        let cellWidth = width / CGFloat(numberOfDigits)

        let center_y = rect.minY + rect.height / 2.0
        UIColor.black.set()
        for i in 0 ..< numberOfDigits {
            switch style {
            case .point:
                let point = CGPoint(x: (CGFloat(i) + 0.5) * cellWidth + Constants.leftMerge, y: center_y)
                context.addArc(center: point, radius: Constants.radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
                if digits.count > i {
                    context.fillPath()
                } else {
                    context.strokePath()
                }
            case let .frame(lineColor, pointColor):
                let frameWith = rect.height - Constants.topMerge - Constants.bottomMerge
                let y = rect.minY + Constants.topMerge
                let x = CGFloat(i) * cellWidth + Constants.leftMerge + (cellWidth - frameWith) / 2.0
                let point = CGPoint(x: x + frameWith / 2.0, y: center_y)
                let rect = CGRect(x: x, y: y, width: frameWith, height: frameWith)
                let path = UIBezierPath(roundedRect: rect, cornerRadius: 6)
                path.lineWidth = 1
                path.lineCapStyle = .round
                path.lineJoinStyle = .round
                context.setStrokeColor(lineColor.cgColor)
                path.stroke()
                if digits.count > i {
                    context.addArc(center: point, radius: Constants.radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
                    context.setFillColor(pointColor.cgColor)
                    context.fillPath()
                } else {
                }
            }
        }
    }
}

// MARK: - Private

extension PasswordField {
    fileprivate struct Constants {
        static let leftMerge: CGFloat = 0
        static let rightMerge: CGFloat = 0
        static let topMerge: CGFloat = 1
        static let bottomMerge: CGFloat = 1
        static let lineWidth: CGFloat = 2
        static let radius: CGFloat = 6
    }

    private func makeup() {
        addSubview(_textField)
        backgroundColor = .white
        _textFieldDelegate.field = self
        _textField.delegate = _textFieldDelegate
        layer.masksToBounds = true
    }
}

class _TextFieldDelegate: NSObject, UITextFieldDelegate {
    weak var field: PasswordField? {
        didSet {
            if #available(iOS 13.0, *) {
                // nothing
            } else {
                if let field = field {
                    field._textField.addTarget(self, action: #selector(textFieldDidChangeSelection(_:)), for: .editingChanged)
                }
            }
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = self.field else { return false }
        guard let text = textField.text else {
            return true
        }
        if string.isEmpty {
            // 移除
            return true
        }
        if !string.isAllDigits {
            return false
        }
        if text.count < field.numberOfDigits {
            // 添加
            return true
        }
        return false
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let field = self.field else { return }
        guard let text = textField.text else {
            field.digits = []
            return
        }
        let numbers: [Int] = text.digits
        field.digits = numbers
    }
}

internal extension String {
    var digits: [Int] {
        return compactMap { (String($0) as NSString).integerValue }
    }

    var isAllDigits: Bool {
        var isAll = true
        for eachChar in self {
            if !((eachChar >= "0") && (eachChar <= "9")) {
                isAll = false
                break
            }
        }
        return isAll
    }
}

internal extension Array where Element == Int {
    var stringValue: String {
        return reduce("", { res, ele in
            var result = res
            result.append("\(ele)")
            return result
        })
    }
}
