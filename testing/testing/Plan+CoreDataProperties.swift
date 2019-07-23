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

    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var deadline: [Date]?
    @NSManaged public var id: UUID?
    @NSManaged public var isComplete: Bool
    @NSManaged public var name: String?
    @NSManaged public var preRequisitePlans: [UUID]?
    @NSManaged public var purpose: String?
    @NSManaged public var goal: Goal?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension Plan {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
