//
//  LoopLabel.swift
//  Label
//
//  Created by lben on 2021/1/17.
//

import UIKit

public
final class LoopLabel: UIView {
    public struct Attributes {
        let contentInset: UIEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
    }

    public var attributes: Attributes = Attributes() {
        didSet {
            _refreshAttributes()
        }
    }

    deinit {
        print("deinit ~ \(self)")
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        _makeup()
    }

    public convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override public var frame: CGRect {
        didSet {
            _layout()
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        _layout()
    }

    @discardableResult
    public func start(with items: [LoopItem], timeInterval: TimeInterval = 3) -> Self {
        _loopContainer.start(with: items, timeInterval: timeInterval)
        return self
    }

    @discardableResult
    public func onDidChangedTo(_ callback: @escaping (LoopItem, LoopLabel) -> Void) -> Self {
        _loopContainer.onDidChangedTo { [weak self] in
            guard let self = self else { return }
            callback($0, self)
        }
        return self
    }

    @discardableResult
    public func onDidSelected(_ callback: @escaping (LoopItem, LoopLabel) -> Void) -> Self {
        _loopContainer.onDidSelected { [weak self] in
            guard let self = self else { return }
            callback($0, self)
        }
        return self
    }

    public func stop() {
        _loopContainer.stop()
    }

    // MARK: - Private

    private let _loopContainer = _LoopContainer()
    private var _currentIndex: Int = 0

    private func _refreshAttributes() {
        _layout()
        //
    }

    private func _makeup() {
        addSubview(_loopContainer)
    }

    private func _layout() {
        _loopContainer.frame = bounds.inset(by: attributes.contentInset)
    }
}

// MARK: - Private

private struct _LoopArray<Element>: IteratorProtocol {
    var items: [Element]
    init(items: [Element] = []) {
        self.items = items
    }

    private var _index: Int = 0

    mutating func next() -> Element? {
        guard !items.isEmpty else { return nil }
        if items.count <= _index + 1 {
            _index = 0
        } else {
            _index += 1
        }
        return items[_index]
    }
}

private class _LoopContainerItemLabel: UILabel {
    var item: LoopItem?

    func render(with item: LoopItem) {
        self.item = item
        text = item.title
        textColor = item.attributes.titleColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init() {
        self.init(frame: .zero)
    }

    // TODO: #lben -  如何实现
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private class _LoopContainer: UIControl {
    private var _timer: Timer?
    private var _loopArray = _LoopArray<LoopItem>()

    private let _labelOne = _LoopContainerItemLabel()
    private let _labelTow = _LoopContainerItemLabel()

    private var _currentLabel: _LoopContainerItemLabel?
    private var _prepLabel: _LoopContainerItemLabel?

    deinit {
        _timer?.invalidate()
        print("deinit ~ \(self)")
    }

    init() {
        super.init(frame: .zero)
        _makeup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _makeup() {
        addSubview(_labelOne)
        addSubview(_labelTow)
    }

    private func scrollToNext() {
        guard let item = _loopArray.next() else {
            stop()
            return
        }
        _prepLabel?.render(with: item)
        _didChangedTo?(item)
        UIView.animate(withDuration: 0.3, animations: {
            let bounds = self.bounds
            self._prepLabel?.frame = bounds
            self._currentLabel?.frame = bounds.inset(by: .init(top: 0, left: 0, bottom: bounds.height, right: 0))
        }, completion: { _ in
            let bounds = self.bounds
            self._currentLabel?.frame = bounds.inset(by: .init(top: bounds.height, left: 0, bottom: 0, right: 0))
            let tmp = self._currentLabel
            self._currentLabel = self._prepLabel
            self._prepLabel = tmp
        })
    }

    func start(with items: [LoopItem], timeInterval: TimeInterval) {
        _loopArray = _LoopArray(items: items)

        _currentLabel = _labelOne
        _didChangedTo?(items[0])
        _currentLabel?.render(with: items[0])
        _prepLabel = _labelTow
        _currentLabel?.frame = bounds
        _prepLabel?.frame = bounds.inset(by: .init(top: bounds.height, left: 0, bottom: 0, right: 0))

        _timer?.invalidate()
        _timer = Timer(timeInterval: timeInterval, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.scrollToNext()
        })
        if let timer = _timer {
            RunLoop.current.add(timer, forMode: .common)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let item = _currentLabel?.item {
            _onDidSelected?(item)
        }
    }

    private var _didChangedTo: ((LoopItem) -> Void)?
    @discardableResult
    public func onDidChangedTo(_ callback: @escaping (LoopItem) -> Void) -> Self {
        _didChangedTo = callback
        return self
    }

    private var _onDidSelected: ((LoopItem) -> Void)?
    @discardableResult
    public func onDidSelected(_ callback: @escaping (LoopItem) -> Void) -> Self {
        _onDidSelected = callback
        return self
    }

    func stop() {
        _timer?.invalidate()
    }
}
