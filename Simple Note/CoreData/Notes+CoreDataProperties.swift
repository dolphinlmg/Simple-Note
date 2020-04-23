//
//  Notes+CoreDataProperties.swift
//  Simple Note
//
//  Created by 이민규 on 2020/04/21.
//  Copyright © 2020 이민규. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var contents: String?
    @NSManaged public var date: Date?
    @NSManaged public var title: String?

}
