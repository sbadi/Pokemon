//
//  LoaderItemView.swift
//  Pokemon
//
//  Created by Alberto Bo on 27/10/2020.
//


import RxCocoa
import RxSwift
import UIKit

class LoaderItemView: UIView {

    private let circle: CAShapeLayer = CAShapeLayer()

    var speed: Double = 1.0 {
        didSet { animate() }
    }

    var lineWidth: CGFloat = 3.0 {
        didSet { animate() }
    }

    var isAnimating: Bool = true {
        didSet { animate() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 64, height: 64)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }

    private func initialization() {
        layer.addSublayer(circle)
        self.tintColor = .separator
        self.backgroundColor = UIColor.background
            .withAlphaComponent(0.4)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        circle.frame = bounds
        animate()
    }

    private func animate() {

        self.layer.cornerRadius = 4.0

        circle.removeAnimation(forKey: "animation")
        self.isHidden = !isAnimating

        if isAnimating == false { return }

        let beginTime: Double = 0.5 * speed
        let strokeStartDuration: Double = 1.2 * speed
        let strokeEndDuration: Double = 0.7 * speed

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.byValue = -CGFloat.pi * 2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        rotationAnimation.duration = strokeStartDuration + beginTime

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = strokeEndDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, .zero, 0.2, 1.0)
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1

        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = strokeStartDuration
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, .zero, 0.2, 1.0)
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = beginTime

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [strokeEndAnimation, strokeStartAnimation, rotationAnimation]
        groupAnimation.duration = strokeStartDuration + beginTime
        groupAnimation.repeatCount = .infinity
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = .forwards

        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2),
                                radius: 25.0,
                                startAngle: 0,
                                endAngle: CGFloat(2.0 * Double.pi),
                                clockwise: false)

        circle.path = path.cgPath
        circle.fillColor = nil
        circle.strokeColor = tintColor.cgColor
        circle.lineWidth = lineWidth
        circle.lineCap = .round
        circle.frame = bounds
        circle.add(groupAnimation, forKey: "animation")
    }
}

extension Reactive where Base: LoaderItemView {
    var isAnimating: Binder<Int> {
        Binder(base) { base, value in base.isAnimating = value > 0 }
    }
}
