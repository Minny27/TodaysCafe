//
//  RecentSearchTag+CoreDataProperties.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/09/02.
//
//

import Foundation
import CoreData


extension RecentSearchTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentSearchTag> {
        return NSFetchRequest<RecentSearchTag>(entityName: "RecentSearchTag")
    }

    @NSManaged public var tagId: String?
    @NSManaged public var tagName: String?

}

extension RecentSearchTag : Identifiable {

}
