//
//  Plan+CoreDataProperties.swift
//  testing
//
//  Created by Ekam Singh Dhaliwal on 2019-07-22.
//  Copyright © 2019 ekam-singh. All rights reserved.
//
//

import Foundation
import CoreData


extension Plan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plan> {
        return NSFetchRequest<Plan>(entityName: "Plan")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var isComplete: Bool
    @NSManaged public var preRequisitePlans: [UUID]?
    @NSManaged public var deadline: [Date]?
    @NSManaged public var taskList: [UUID]?
    @NSManaged public var purpose: String?

}
