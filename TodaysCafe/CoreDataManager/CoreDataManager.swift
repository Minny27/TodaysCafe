//
//  CoreDataManager.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/09/01.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = appDelegate?.persistentContainer.viewContext

    let modelName: String = "RecentSearchTag"
    
    func saveRecentTag(_ tagId: String, _ tagName: String) {
        var recentSearchTagIdSet: Set<String> = []
        guard let context = self.context, let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: modelName, in: context) else { return }
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
        do {
            guard let fetchResult: [RecentSearchTag] = try (context.fetch(fetchRequest) as? [RecentSearchTag]) else { return }
            for index in 0..<fetchResult.count {
                if let tagInfo = fetchResult[index].tagId {
                    if !recentSearchTagIdSet.contains(tagInfo) {
                        recentSearchTagIdSet.insert(tagInfo)
                    }
                }
                else {
                    context.delete(fetchResult[index])
                }
            }
            
            guard let recentTagInfo = NSManagedObject(entity: entity, insertInto: context) as? RecentSearchTag else { return }
            
            if !recentSearchTagIdSet.contains(tagId) {
                recentTagInfo.tagId = tagId
                recentTagInfo.tagName = tagName
            }
        
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            try context.save()
        } catch {
            print("Error!")
        }
    }
    
    func getRecentTag() -> [RecentSearchTag] {
        var recentSearchTagList: [RecentSearchTag] = []
        if let context = self.context {
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            do {
                if let fetchResult: [RecentSearchTag] = try context.fetch(fetchRequest) as? [RecentSearchTag] {
                    recentSearchTagList = fetchResult
                }

            } catch {
                print(error.localizedDescription)
                return []
            }
        }
        
        return recentSearchTagList
    }
}

