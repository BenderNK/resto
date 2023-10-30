//
//  ImageWrapper.swift
//  resto
//
//  Created by Turker Nessa Kucuk on 10/30/23.
//

import UIKit

struct ImageWrapper: Hashable, Codable {
    let image: UIImage
    
    enum CodingKeys: String, CodingKey {
        case image
    }
    
    init(image: UIImage) {
        self.image = image
    }
    
    init?(optionalImage: UIImage?) {
        if let validImage = optionalImage {
            self.image = validImage
        } else {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.image)
        guard let image = UIImage(data: data) else {
            throw "an image cannot be created from provided data"
        }
        
        self.image = image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard let data = image.toData() else {
            throw "image cannot be converted to either jpg or png data"
        }
        
        try container.encode(data, forKey: CodingKeys.image)
    }
}

extension String: Error {
    
}
