//
//  Skeletonable+Internal.swift
//  
//
//  Created by Will Wang on 8/25/21.
//

import UIKit

extension Skeletonable {
    var skeletonLayerName: String {
        return "skeletonLayerName"
    }

    var skeletonGradientName: String {
        return "skeletonGradientName"
    }
    
    private var placeholderText: String {
        return "placeholderText"
    }
    
    private var mainColor: CGColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray5.cgColor
        } else {
            return UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0).cgColor
        }
    }
    
    private var highlightColor: CGColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemBackground.cgColor
        } else {
            return UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
        }
    }

    func searchViews(in view: UIView) -> [UIView] {
        var results = [UIView]()
        
        for subview in view.subviews as [UIView] {
            switch subview {
            case _ where subview.isKind(of: UILabel.self):
                if let label = subview as? UILabel {
                    label.text = placeholderText
                    results += [label]
                } else {
                    results += [subview]
                }
            case _ where subview.isKind(of: UIImageView.self):
                results += [subview]
            case _ where subview.isKind(of: UIButton.self):
                results += [subview]
            default:
                results += searchViews(in: subview)
            }
        }
        return results
    }
    
    func createGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [mainColor, highlightColor, mainColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.name = skeletonGradientName
        return gradientLayer
    }
    
    func createSkeletonLayer() -> CALayer {
        let skeletonLayer = CALayer()
        skeletonLayer.backgroundColor = mainColor
        skeletonLayer.name = skeletonLayerName
        skeletonLayer.anchorPoint = .zero
        skeletonLayer.frame.size = UIScreen.main.bounds.size
        return skeletonLayer
    }
    
    func createAnimation() -> CABasicAnimation {
        let widht = UIScreen.main.bounds.width
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.fromValue = -widht
        animation.toValue = widht
        animation.repeatCount = .infinity
        animation.autoreverses = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        return animation
    }

    func setupSkeletonEffect(_ view: UIView, _ backgroundLayer: CALayer) {
        let gradientLayer = createGradientLayer()
        view.layer.mask = backgroundLayer
        view.layer.addSublayer(backgroundLayer)
        view.layer.addSublayer(gradientLayer)
        view.clipsToBounds = true
        gradientLayer.add(createAnimation(), forKey: "gradientLayerShimmerAnimation")
    }
}

