//
//  String+Localized.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/28/23.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(with parameters: CVarArg...) -> String {
        return String(format: self.localized(), arguments: parameters)
    }
    
    /// you don't generally call this function directly, it is meant to be called
    /// by another function that takes CVarArg... as arguments
    func localized(usingPointer pointerToVarArgs: CVaListPointer) -> String {
        return NSString(format: self.localized(), arguments: pointerToVarArgs) as String
    }
}
