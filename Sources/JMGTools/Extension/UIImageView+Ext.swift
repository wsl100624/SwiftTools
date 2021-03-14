//
//  UIImageView+Ext.swift
//  
//
//  Created by Will Wang on 3/13/21.
//

import UIKit

extension UIImageView {
    convenience public init(image: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFill) {
        self.init(image: image)
        self.contentMode = contentMode
        self.clipsToBounds = true
    }
}
