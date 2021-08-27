//
//  Mug.swift
//  testApp1
//
//  Created by Sergey Ivanov on 23.08.2021.
//

import UIKit

class FetchMugImages {
    
    
    func fetchMugImages() -> [ImageAndText] {
        var images = [ImageAndText]()
        
        for imageIndex in 0..<10 {
            guard let image = UIImage(named: "img\(imageIndex).png") else { break }
            images.append(ImageAndText(image: image, text: generateText()))
        }
        return images
    }
    
    func generateText() -> String? {
        let randomValue = Bool.random()
        if randomValue {
            return "Описание для изображения"
        }
        return nil
    }
}
