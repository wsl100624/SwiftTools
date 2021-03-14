//
//  Int+Ext.swift
//  
//
//  Created by Will Wang on 3/13/21.
//

import Foundation


extension Int {
    
    /// Format raw seconds. for example 65 seconds
    /// - Returns: 1m 5s
    public func formatSeconds() -> (hr: Int, min: Int, sec: Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
}

extension TimeInterval {
    
    /// Format raw seconds. for example 65 seconds
    /// - Returns: 1m 5s
    public func formatSeconds() -> (hr: Int, min: Int, sec: Int) {
        return (Int(self) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
    }
}
