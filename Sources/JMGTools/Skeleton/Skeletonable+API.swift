//
//  Skeletonable+API.swift
//  
//
//  Created by Will Wang on 8/25/21.
//

import UIKit

public protocol Skeletonable {
    func showSkeleton()
    func hideSkeleton()
}

public extension Skeletonable where Self: UIViewController {
    
    /// Use in viewDidAppear
    func showSkeleton() {
        let skeletonLayer = createSkeletonLayer()
        searchViews(in: view).forEach {
            setupSkeletonEffect($0, skeletonLayer)
        }
    }
    
    /// Use when the actually data is ready
    func hideSkeleton() {
        searchViews(in: view).forEach {
            $0.layer.sublayers?.removeAll {
                $0.name == skeletonLayerName || $0.name == skeletonGradientName
            }
        }
    }
}

