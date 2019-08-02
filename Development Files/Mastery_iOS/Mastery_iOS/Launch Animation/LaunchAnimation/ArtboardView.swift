// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import UIKit

@IBDesignable
public class ArtboardView: UIView {
    public struct Defaults {
        public static let size = CGSize(width: 414, height: 736)
        public static let backgroundColor = UIColor(red: 0.169, green: 0.476, blue: 1, alpha: 0)
    }

    public var masteryIcon: UIView!
    public var leftFoot: ShapeView!
    public var rightFoot: ShapeView!
    public var leftArm: ShapeView!
    public var rightArm: ShapeView!
    public var head: ShapeView!
    public var shadowRight: ShapeView!
    public var shadowLeft: ShapeView!

    public override var intrinsicContentSize: CGSize {
        return Defaults.size
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = Defaults.backgroundColor
        createViews()
        addSubviews()
        //scale(to: frame.size)
    }

    /// Scales `self` and its subviews to `size`.
    ///
    /// - Parameter size: The size `self` is scaled to.
    ///
    /// UIKit specifies: "In iOS 8.0 and later, the transform property does not affect Auto Layout. Auto layout
    /// calculates a view's alignment rectangle based on its untransformed frame."
    ///
    /// see: https://developer.apple.com/documentation/uikit/uiview/1622459-transform
    ///
    /// If there are any constraints in IB affecting the frame of `self`, this method will have consequences on
    /// layout / rendering. To properly scale an animation, you will have to position the view manually.
    public func scale(to size: CGSize) {
        let x = size.width / Defaults.size.width
        let y = size.height / Defaults.size.height
        transform = CGAffineTransform(scaleX: x, y: y)
    }

    private func createViews() {
        CATransaction.suppressAnimations {
            createMasteryIcon()
            createLeftFoot()
            createRightFoot()
            createLeftArm()
            createRightArm()
            createHead()
            createShadowRight()
            createShadowLeft()
        }
    }

    private func createMasteryIcon() {
        masteryIcon = UIView(frame: CGRect(x: 204.59, y: 373.66, width: 259.83, height: 250.98))
        masteryIcon.backgroundColor = UIColor.clear
        masteryIcon.layer.shadowOffset = CGSize(width: 0, height: 0)
        masteryIcon.layer.shadowColor = UIColor.clear.cgColor
        masteryIcon.layer.shadowOpacity = 1
        masteryIcon.layer.position = CGPoint(x: 190, y: 373.66)
        masteryIcon.layer.bounds = CGRect(x: 0, y: 0, width: 259.83, height: 250.98)
        masteryIcon.layer.masksToBounds = true
    }

    private func createLeftFoot() {
        leftFoot = ShapeView(frame: CGRect(x: 22.7, y: 119.32, width: 66.77, height: 196.28))
        leftFoot.backgroundColor = UIColor.clear
        leftFoot.alpha = 0
        leftFoot.transform = CGAffineTransform(rotationAngle: -0.138889 * CGFloat.pi)
        leftFoot.layer.shadowOffset = CGSize(width: 0, height: 0)
        leftFoot.layer.shadowColor = UIColor.clear.cgColor
        leftFoot.layer.shadowOpacity = 1
        leftFoot.layer.position = CGPoint(x: 22.7, y: 119.32)
        leftFoot.layer.bounds = CGRect(x: 0, y: 0, width: 66.77, height: 196.28)
        leftFoot.layer.masksToBounds = false
        leftFoot.shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        leftFoot.shapeLayer.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        leftFoot.shapeLayer.lineDashPattern = []
        leftFoot.shapeLayer.lineDashPhase = 0
        leftFoot.shapeLayer.lineWidth = 0
        leftFoot.shapeLayer.path = CGPathCreateWithSVGString("M66.77,143.193s0,0,0,0c0,0,-27.632,45.059,-27.632,45.059s0,0,0,0c0,0,-8.79,11.592,-19.333,6.447 -10.543,-5.145,-19.805,-10.593,-19.805,-10.593s0,0,0,0c0,0,0,-24.455,0,-40.912 0,0,66.179,-143.193,66.179,-143.193s0,0,0,0c0,0,0.591,143.193,0.591,143.193zM66.77,143.193")!

    }

    private func createRightFoot() {
        rightFoot = ShapeView(frame: CGRect(x: 244.31, y: 119.32, width: 66.77, height: 196.28))
        rightFoot.backgroundColor = UIColor.clear
        rightFoot.alpha = 0
        rightFoot.transform = CGAffineTransform(rotationAngle: -0.138889 * CGFloat.pi)
        rightFoot.transform = rightFoot.transform.scaledBy(x: -1, y: 1)
        rightFoot.layer.shadowOffset = CGSize(width: 0, height: 0)
        rightFoot.layer.shadowColor = UIColor.clear.cgColor
        rightFoot.layer.shadowOpacity = 1
        rightFoot.layer.position = CGPoint(x: 244.31, y: 119.32)
        rightFoot.layer.bounds = CGRect(x: 0, y: 0, width: 66.77, height: 196.28)
        rightFoot.layer.masksToBounds = false
        rightFoot.shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        rightFoot.shapeLayer.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        rightFoot.shapeLayer.lineDashPattern = []
        rightFoot.shapeLayer.lineDashPhase = 0
        rightFoot.shapeLayer.lineWidth = 0
        rightFoot.shapeLayer.path = CGPathCreateWithSVGString("M66.77,143.193s0,0,0,0c0,0,-27.632,45.059,-27.632,45.059s0,0,0,0c0,0,-8.79,11.592,-19.333,6.447 -10.543,-5.145,-19.805,-10.593,-19.805,-10.593s0,0,0,0c0,0,0.591,0,0.591,0s0,0,0,0c0,0,0,-22.9,0,-39.357 0,0,65.588,-144.748,65.588,-144.748s0,0,0,0c0,0,0.591,143.193,0.591,143.193zM66.77,143.193")!

    }

    private func createLeftArm() {
        leftArm = ShapeView(frame: CGRect(x: 31.77, y: 134.74, width: 63.55, height: 208.35))
        leftArm.backgroundColor = UIColor.clear
        leftArm.alpha = 0
        leftArm.transform = CGAffineTransform(rotationAngle: 0.25 * CGFloat.pi)
        leftArm.layer.shadowOffset = CGSize(width: 0, height: 0)
        leftArm.layer.shadowColor = UIColor.clear.cgColor
        leftArm.layer.shadowOpacity = 1
        leftArm.layer.position = CGPoint(x: 31.77, y: 134.74)
        leftArm.layer.bounds = CGRect(x: 0, y: 0, width: 63.55, height: 208.35)
        leftArm.layer.masksToBounds = false
        leftArm.shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        leftArm.shapeLayer.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        leftArm.shapeLayer.lineDashPattern = []
        leftArm.shapeLayer.lineDashPhase = 0
        leftArm.shapeLayer.lineWidth = 0
        leftArm.shapeLayer.path = CGPathCreateWithSVGString("M33.464,0s0,0,0,0c0,0,-27.06,15.75,-27.06,15.75s0,0,0,0c0,0,-6.243,4.443,-6.243,13.914 0,9.471,0,130.797,0,130.797s0,0,0,0c0,0,-1.455,8.653,10.239,15.901 11.694,7.248,53.15,31.988,53.15,31.988s0,0,0,0c0,0,-0,-157.216,-0,-157.216s0,0,0,0c0,0,-30.086,-51.134,-30.086,-51.134zM33.464,0")!

    }

    private func createRightArm() {
        rightArm = ShapeView(frame: CGRect(x: 228.05, y: 134.74, width: 63.55, height: 208.35))
        rightArm.backgroundColor = UIColor.clear
        rightArm.alpha = 0
        rightArm.transform = CGAffineTransform(rotationAngle: -0.25 * CGFloat.pi)
        rightArm.layer.shadowOffset = CGSize(width: 0, height: 0)
        rightArm.layer.shadowColor = UIColor.clear.cgColor
        rightArm.layer.shadowOpacity = 1
        rightArm.layer.position = CGPoint(x: 228.05, y: 134.74)
        rightArm.layer.bounds = CGRect(x: 0, y: 0, width: 63.55, height: 208.35)
        rightArm.layer.masksToBounds = false
        rightArm.shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        rightArm.shapeLayer.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        rightArm.shapeLayer.lineDashPattern = []
        rightArm.shapeLayer.lineDashPhase = 0
        rightArm.shapeLayer.lineWidth = 0
        rightArm.shapeLayer.path = CGPathCreateWithSVGString("M30.086,0s0,0,0,0c0,0,27.06,15.75,27.06,15.75 4.162,2.962,6.243,7.6,6.243,13.914l0,130.797c0.97,5.769,-2.443,11.069,-10.239,15.901 -7.796,4.832,-25.513,15.495,-53.15,31.988 0,0,0,-157.216,0,-157.216s0,0,0,0c0,0,30.086,-51.134,30.086,-51.134zM30.086,0")!

    }

    private func createHead() {
        head = ShapeView(frame: CGRect(x: 129.91, y: 98.94, width: 192.26, height: 197.89))
        head.backgroundColor = UIColor.clear
        head.alpha = 0
        head.layer.shadowOffset = CGSize(width: 0, height: 0)
        head.layer.shadowColor = UIColor.clear.cgColor
        head.layer.shadowOpacity = 1
        head.layer.position = CGPoint(x: 129.91, y: 98.94)
        head.layer.bounds = CGRect(x: 0, y: 0, width: 192.26, height: 197.89)
        head.layer.masksToBounds = false
        head.shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        head.shapeLayer.fillColor = UIColor.white.cgColor
        head.shapeLayer.lineDashPattern = []
        head.shapeLayer.lineDashPhase = 0
        head.shapeLayer.lineWidth = 0
        head.shapeLayer.path = CGPathCreateWithSVGString("M96.72,197.89s0,0,0,0c0,0,95.54,-167.896,95.54,-167.896s0,0,0,0c0,0,-41.914,-24.116,-41.914,-24.116s0,0,0,0c0,0,-17.704,-11.247,-25.748,0 -8.045,11.247,-28.467,48.326,-28.467,48.326s0,0,0,0c0,0,-27.846,-48.326,-27.846,-48.326s0,0,0,0c0,0,-8.649,-11.756,-26.925,0 -18.276,11.756,-41.359,24.116,-41.359,24.116s0,0,0,0c0,0,96.72,167.896,96.72,167.896zM96.72,197.89")!

    }

    private func createShadowRight() {
        shadowRight = ShapeView(frame: CGRect(x: 163, y: 139.57, width: 66.55, height: 116.64))
        shadowRight.backgroundColor = UIColor.clear
        shadowRight.alpha = 0
        shadowRight.transform = shadowRight.transform.scaledBy(x: -1, y: 1)
        shadowRight.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowRight.layer.shadowColor = UIColor.clear.cgColor
        shadowRight.layer.shadowOpacity = 1
        shadowRight.layer.position = CGPoint(x: 163, y: 139.57)
        shadowRight.layer.bounds = CGRect(x: 0, y: 0, width: 66.55, height: 116.64)
        shadowRight.layer.masksToBounds = false
        shadowRight.shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        shadowRight.shapeLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        shadowRight.shapeLayer.lineDashPattern = []
        shadowRight.shapeLayer.lineDashPhase = 0
        shadowRight.shapeLayer.lineWidth = 0
        shadowRight.shapeLayer.path = CGPathCreateWithSVGString("M0.004,0s0,0,0,0c0,0,66.55,116.64,66.55,116.64s0,0,0,0c0,0,-66.55,-97.678,-66.55,-97.678s0,0,0,0c0,0,0,-18.962,0,-18.962zM0.004,0")!

    }

    private func createShadowLeft() {
        shadowLeft = ShapeView(frame: CGRect(x: 97.63, y: 139.57, width: 66.55, height: 116.64))
        shadowLeft.backgroundColor = UIColor.clear
        shadowLeft.alpha = 0
        shadowLeft.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLeft.layer.shadowColor = UIColor.clear.cgColor
        shadowLeft.layer.shadowOpacity = 1
        shadowLeft.layer.position = CGPoint(x: 97.63, y: 139.57)
        shadowLeft.layer.bounds = CGRect(x: 0, y: 0, width: 66.55, height: 116.64)
        shadowLeft.layer.masksToBounds = false
        shadowLeft.shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        shadowLeft.shapeLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        shadowLeft.shapeLayer.lineDashPattern = []
        shadowLeft.shapeLayer.lineDashPhase = 0
        shadowLeft.shapeLayer.lineWidth = 0
        shadowLeft.shapeLayer.path = CGPathCreateWithSVGString("M0.004,0s0,0,0,0c0,0,66.55,116.64,66.55,116.64s0,0,0,0c0,0,-66.55,-97.678,-66.55,-97.678s0,0,0,0c0,0,0,-18.962,0,-18.962zM0.004,0")!

    }

    private func addSubviews() {
        masteryIcon.addSubview(leftFoot)
        masteryIcon.addSubview(rightFoot)
        masteryIcon.addSubview(leftArm)
        masteryIcon.addSubview(rightArm)
        masteryIcon.addSubview(head)
        masteryIcon.addSubview(shadowRight)
        masteryIcon.addSubview(shadowLeft)
        addSubview(masteryIcon)
    }
}
