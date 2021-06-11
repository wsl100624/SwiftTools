//
//  JMGLoadingView.swift
//  
//
//  Created by Will Wang on 6/11/21.
//

import UIKit

@available(iOS 13.0, *)
open class JMGLoadingView: UIView {
    
    public enum BackgroundStyle {
        case light
        case dark
        case clear
    }
    
    var backgroundStyle: BackgroundStyle
    var text: String
    
    lazy var textLabel = UILabel(font: .preferredFont(forTextStyle: .callout), textColor: .init(white: 1, alpha: 0.6), textAlignment: .center, numberOfLines: 0)
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }()
    
    public init(_ backgroundStyle: BackgroundStyle = .light, text: String = "") {
        self.text = text
        self.backgroundStyle = backgroundStyle
        super.init(frame: .zero)
        
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        switch backgroundStyle {
        case .light:
            backgroundColor = .init(white: 1, alpha: 0.6)
            textLabel.textColor = .secondaryLabel
        case .dark:
            loadingIndicator.color = .init(white: 1, alpha: 0.6)
            textLabel.textColor = .white
            backgroundColor = .init(white: 0.3, alpha: 0.6)
        case .clear:
            backgroundColor = .clear
        }
        
        textLabel.text = text
    }
    
    open override func layoutSubviews() {
        layout()
    }
    
    private func layout() {
        isHidden = true
        
        let sv = stackView(loadingIndicator, textLabel, spacing: 12)
        addSubview(sv)
        sv.centerInSuperview(size: .init(width: 300, height: 50))
        
        textLabel.isHidden = text == ""
    }
    
    // MARK: - Action
    
    open func run() {
        isHidden = false
        loadingIndicator.startAnimating()
    }
    
    open func stop() {
        isHidden = true
        loadingIndicator.stopAnimating()
    }
}
