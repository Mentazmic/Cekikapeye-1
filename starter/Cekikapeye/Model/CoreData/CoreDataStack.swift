//
//  CoreDataStack.swift
//  Cekikapeye
//
//  Created by Maxime Landu-Wa on 16/03/2022.
//  Copyright © 2022 OpenClassrooms. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    //MARK: -Private

    private let persistantContainerName = "Cekikapeye"

    //MARK: -Singleton
    static let sharedInstance = CoreDataStack()

    //MARK: -Private

    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistantContainer.viewContext
    }

    //MARK: -Private
    private init () {}

    private lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistantContainerName)
        container.loadPersistentStores (completionHandler: { StoreDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(StoreDescription.description)")
            }
        })
        return container
    }()
}
