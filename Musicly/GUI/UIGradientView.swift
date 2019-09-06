//
//  UIGradientView.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

private enum EncodingKey: String {
    case startColor
    case endColor
    case isVertical
}

protocol Gradientable: class {
    var startColor: UIColor? { get set }
    var endColor: UIColor? { get set }
    var isVertical: Bool { get set }
}

private extension Gradientable {
    func setupGradient() {
        // To be defined in classes
    }
}

extension UIGradientView: Gradientable { }
extension UIGradientTableView: Gradientable { }
extension UIGradientCollectionView: Gradientable { }

@IBDesignable open class UIGradientView: UIView {

    // MARK: - Inspectable attributes

    @IBInspectable var startColor: UIColor? = UIColor.clear {
        didSet { setupGradient() }
    }

    @IBInspectable var endColor: UIColor? = UIColor.clear {
        didSet { setupGradient() }
    }

    @IBInspectable var isVertical: Bool = true {
        didSet { setupGradient() }
    }

    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startColor = aDecoder.decodeObject(forKey: EncodingKey.startColor.rawValue) as? UIColor ?? UIColor.clear
        endColor = aDecoder.decodeObject(forKey: EncodingKey.endColor.rawValue) as? UIColor ?? UIColor.clear
        isVertical = aDecoder.decodeBool(forKey: EncodingKey.isVertical.rawValue)
    }

    // MARK: - Layout updates

    override open func layoutSubviews() {
        super.layoutSubviews()
        // Force the gradient layer to be behind all others
        if let gradientLayer = gradientLayer {
            gradientLayer.removeFromSuperlayer()
            gradientLayer.frame = bounds
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }

    // MARK: - Private

    private var gradientLayer: CAGradientLayer!

    private func setupGradient() {
        gradientLayer?.removeFromSuperlayer()
        guard let startColor = startColor, let endColor = endColor else {
            return
        }
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [ startColor.cgColor, endColor.cgColor ]
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.masksToBounds = layer.cornerRadius > 0.0
        gradientLayer.borderColor = layer.borderColor
        gradientLayer.borderWidth = layer.borderWidth
        gradientLayer.transform = isVertical ? CATransform3DIdentity : CATransform3DMakeRotation(-CGFloat.pi / 2.0, 0.0, 0.0, 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - NSCoding

extension UIGradientView/*: NSCoding*/ {

    open override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(startColor, forKey: EncodingKey.startColor.rawValue)
        aCoder.encode(endColor, forKey: EncodingKey.endColor.rawValue)
        aCoder.encode(isVertical, forKey: EncodingKey.isVertical.rawValue)
    }

}

@IBDesignable open class UIGradientTableView: UITableView {

    // MARK: - Inspectable attributes

    @IBInspectable var startColor: UIColor? = UIColor.clear {
        didSet { setupGradient() }
    }

    @IBInspectable var endColor: UIColor? = UIColor.clear {
        didSet { setupGradient() }
    }

    @IBInspectable var isVertical: Bool = true {
        didSet { setupGradient() }
    }

    // MARK: - Initializers

    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startColor = aDecoder.decodeObject(forKey: EncodingKey.startColor.rawValue) as? UIColor ?? UIColor.clear
        endColor = aDecoder.decodeObject(forKey: EncodingKey.endColor.rawValue) as? UIColor ?? UIColor.clear
        isVertical = aDecoder.decodeBool(forKey: EncodingKey.isVertical.rawValue)
    }

    // MARK: - Private

    internal var gradientView: UIGradientView!

    private func setupGradient() {
        self.gradientView = UIGradientView(frame: self.bounds)
        self.gradientView.startColor = self.startColor
        self.gradientView.endColor = self.endColor
        self.gradientView.isVertical = self.isVertical
        self.backgroundView = self.gradientView
    }

}

// MARK: - NSCoding

extension UIGradientTableView/*: NSCoding*/ {

    open override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(startColor, forKey: EncodingKey.startColor.rawValue)
        aCoder.encode(endColor, forKey: EncodingKey.endColor.rawValue)
        aCoder.encode(isVertical, forKey: EncodingKey.isVertical.rawValue)
    }

}

@IBDesignable open class UIGradientCollectionView: UICollectionView {

    // MARK: - Inspectable attributes

    @IBInspectable var startColor: UIColor? = UIColor.clear {
        didSet { setupGradient() }
    }

    @IBInspectable var endColor: UIColor? = UIColor.clear {
        didSet { setupGradient() }
    }

    @IBInspectable var isVertical: Bool = true {
        didSet { setupGradient() }
    }

    // MARK: - Initializers

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startColor = aDecoder.decodeObject(forKey: EncodingKey.startColor.rawValue) as? UIColor ?? UIColor.clear
        endColor = aDecoder.decodeObject(forKey: EncodingKey.endColor.rawValue) as? UIColor ?? UIColor.clear
        isVertical = aDecoder.decodeBool(forKey: EncodingKey.isVertical.rawValue)
    }

    // MARK: - Private

    internal var gradientView: UIGradientView!

    private func setupGradient() {
        self.gradientView = UIGradientView(frame: self.bounds)
        self.gradientView.startColor = self.startColor
        self.gradientView.endColor = self.endColor
        self.gradientView.isVertical = self.isVertical
        self.backgroundView = self.gradientView
    }

}

// MARK: - NSCoding

extension UIGradientCollectionView/*: NSCoding*/ {

    open override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(startColor, forKey: EncodingKey.startColor.rawValue)
        aCoder.encode(endColor, forKey: EncodingKey.endColor.rawValue)
        aCoder.encode(isVertical, forKey: EncodingKey.isVertical.rawValue)
    }

}
