//
//  JMGLoadingButton.swift
//  
//
//  Created by Will Wang on 3/18/21.
//

import UIKit

@available(iOS 13.0, *)
open class JMGLoadingButton: UIButton {
    
    open var indicatorColor: UIColor = .white
    open var indicatorStyle: UIActivityIndicatorView.Style = .medium
    
    private var originalTitleColor: UIColor = .white
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: indicatorStyle)
        indicator.color = indicatorColor
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    open func showLoading() {
        originalTitleColor = self.currentTitleColor
        setTitleColor(UIColor.clear, for: .normal)
        
        self.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
    }
    
    open func hideLoading() {
        DispatchQueue.main.async(execute: {
            self.setTitleColor(self.originalTitleColor, for: .normal)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        })
    }
}
