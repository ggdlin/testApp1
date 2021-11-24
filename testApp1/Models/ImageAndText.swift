//
//  ImageAndText.swift
//  testApp1
//
//  Created by Sergey Ivanov on 23.08.2021.
//

import UIKit
import CoreData


@objcMembers
class ImageAndText: NSObject {
    var dbid: NSManagedObjectID?
    let image: UIImage
    var text: String?
    
    init(dbid: NSManagedObjectID? = nil, image: UIImage, text: String? = nil) {
        self.dbid = dbid
        self.image = image
        self.text = text
    }
}
