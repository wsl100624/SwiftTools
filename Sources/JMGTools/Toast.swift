//
//  Toast.swift
//  
//
//  Created by Will Wang on 3/13/21.
//

import UIKit

open class Toast {
    
    public let shared = Toast()
    
    public enum ToastPosition {
        case top
        case bottom
        case center
    }
    
    private var box = [Bread]()
    
    open func make(_ text: String,
              position: ToastPosition = .bottom,
              padding: CGFloat = 100,
              textColor: UIColor = .init(white: 0.95, alpha: 1),
              backgroundColor: UIColor = .init(white: 0.05, alpha: 0.85),
              font: UIFont = .systemFont(ofSize: 16, weight: .medium),
              delay: TimeInterval = 1) {
        
        let bread = Bread(text, position, padding, textColor, backgroundColor, font, delay)
        
        if box.isEmpty {
            box.append(bread)
            makeToast()
        } else {
            box.append(bread)
        }
    }
    
    private func makeToast() {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let bread = box.first else { return }
        
        let label = ToastLabel(bread)
        window.addSubview(label)
        
        UIView.animate(withDuration: 0.5, animations: {
            label.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: bread.delay, animations: {
                print(bread.delay)
                label.alpha = 0
            }) { _ in
                label.removeFromSuperview()
                
                self.box.removeFirst()
                if !self.box.isEmpty {
                    self.makeToast()
                }
            }
            
        }
    }
    
}



fileprivate struct Bread {
    
    internal init(_ text: String, _ position: Toast.ToastPosition, _ padding: CGFloat, _ textColor: UIColor, _ backgroundColor: UIColor, _ font: UIFont, _ delay: TimeInterval) {
        self.text = text
        self.position = position
        self.padding = padding
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.delay = delay
    }
    
    let text: String
    let position: Toast.ToastPosition
    let padding: CGFloat
    let textColor: UIColor
    let backgroundColor: UIColor
    let font: UIFont
    let delay: TimeInterval
}


fileprivate class ToastLabel: UILabel {
    
    let toastBackgroundColor = UIColor.init(white: 0.05, alpha: 0.85)
    let toastTextColor = UIColor.init(white: 0.95, alpha: 1)
    let toastFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    
    var bread: Bread
    
    init(_ bread: Bread) {
        self.bread = bread
        super.init(frame: .zero)
        
        text = bread.text
        font = bread.font
        textColor = bread.textColor
        backgroundColor = bread.backgroundColor
        
        textAlignment = .center
        numberOfLines = 0
        clipsToBounds = true
        alpha = 0
    }
    
    override func layoutSubviews() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let labelHeight = intrinsicContentSize.width / window.frame.width * 40
        let labelWidth = min(intrinsicContentSize.width, window.frame.width - 80) + 36
        let adjustedHeight = max(labelHeight, intrinsicContentSize.height + 26)
        
        var y: CGFloat
        
        switch bread.position {
        case .top:
            y = bread.padding
        case .bottom:
            y = (window.frame.height - bread.padding) - adjustedHeight
        default:
            y = window.center.y - (adjustedHeight / 2)
        }
        
        frame = CGRect(x: .zero, y: y, width: labelWidth, height: adjustedHeight)
        center.x = window.center.x
        layer.cornerRadius = frame.height / 2
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        super.drawText(in: rect.inset(by: insets))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
