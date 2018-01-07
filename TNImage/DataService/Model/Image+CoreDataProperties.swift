//
//  Image+CoreDataProperties.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/5/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var urlFull: String?
    @NSManaged public var urlPreview: String?
    @NSManaged public var title: String?

}
