//
//  ErrorView.swift
//  
//
//  Created by Will Wang on 3/13/21.
//

import UIKit


@available(iOS 13.0, *)
open class RefreshView: UIView {
    
    var errorString: String
    var labelColor: UIColor
    var retryLabelColor: UIColor
    
    var tap: (() -> ())?
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let centerParagraphStyle = NSMutableParagraphStyle()
        centerParagraphStyle.alignment = .center
        let attributedString = NSMutableAttributedString(string: "\(errorString)\n\nTouch to retry", attributes: [.paragraphStyle: centerParagraphStyle, .foregroundColor:labelColor, .font: UIFont.systemFont(ofSize: 15)])
        attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), .foregroundColor : retryLabelColor], range: .init(location: errorString.count, length: 16))
        label.attributedText = attributedString
        return label
    }()
    
    lazy var refreshImageView: UIImageView = {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .medium)
        let iv = UIImageView(image: UIImage(systemName: "arrow.clockwise.circle.fill", withConfiguration: imageConfig)!.withTintColor(.systemFill, renderingMode: .alwaysOriginal))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var rootSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [refreshImageView, errorLabel])
        sv.axis = .vertical
        refreshImageView.constrainHeight(100)
        sv.isUserInteractionEnabled = true
        sv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        return sv
    }()
    
    public init(errorString: String, labelColor: UIColor = .label, retryLabelColor: UIColor = .secondaryLabel, handler: @escaping (() -> ())) {
        self.errorString = errorString
        self.labelColor = labelColor
        self.retryLabelColor = retryLabelColor
        self.tap = handler
        super.init(frame: .zero)
        
        backgroundColor = .clear
    }
    
    open override func layoutSubviews() {
        addSubview(rootSV)
        rootSV.centerInSuperview(size: .init(width: frame.width - 48, height: 200))
    }
    
    @objc private func handleTap() {
        tap?()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

