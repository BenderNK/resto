//
//  UIImage+Data.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/30/23.
//

import UIKit

/// Helper UIImage extension.
extension UIImage {
    /// Checks if image has alpha component
    var hasAlphaChannel: Bool {
        let result: Bool
        
        guard let alpha = cgImage?.alphaInfo else {
            return false
        }
        
        switch alpha {
        case .none, .noneSkipFirst, .noneSkipLast:
            result = false
        default:
            result = true
        }
        
        return result
    }
    
    /// if the underlying image has alpha channel, converts the image to png.
    /// if there are no alpha channel, then converts to image to jpg with no compression
    func toData() -> Data? {
        return hasAlphaChannel
        ? pngData()
        : jpegData(compressionQuality: 1.0)
    }
}
