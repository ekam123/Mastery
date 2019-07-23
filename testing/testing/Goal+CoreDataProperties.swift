//
//  Goal+CoreDataProperties.swift
//  testing
//
//  Created by Ekam Singh Dhaliwal on 2019-07-22.
//  Copyright © 2019 ekam-singh. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var deadline: [Date]?
    @NSManaged public var id: UUID?
    @NSManaged public var isComplete: Bool
    @NSManaged public var name: String?
    @NSManaged public var purpose: String?
    @NSManaged public var user: User?
    @NSManaged public var plans: NSSet?

}

// MARK: Generated accessors for plans
extension Goal {

    @objc(addPlansObject:)
    @NSManaged public func addToPlans(_ value: Plan)

    @objc(removePlansObject:)
    @NSManaged public func removeFromPlans(_ value: Plan)

    @objc(addPlans:)
    @NSManaged public func addToPlans(_ values: NSSet)

    @objc(removePlans:)
    @NSManaged public func removeFromPlans(_ values: NSSet)

}
