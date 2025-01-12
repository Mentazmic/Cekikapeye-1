//
//  PeopleRepository.swift
//  Cekikapeye
//
//  Created by Maxime Landu-Wa on 16/03/2022.
//  Copyright © 2022 OpenClassrooms. All rights reserved.
//

import Foundation
import CoreData

final class PeopleRepository {

   // MARK: - Properties

   private let coreDataStack: CoreDataStack

   // MARK: - Init

   init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
      self.coreDataStack = coreDataStack
   }

   // MARK: - Repository

   func getPersons(completion: ([Person]) -> Void) {
      let request: NSFetchRequest<Person> = Person.fetchRequest()
      do {
        let persons = try coreDataStack.viewContext.fetch(request)
        completion(persons)
      } catch {
        completion([])
      }
   }

   func savePerson(named name: String, completion: () -> Void) {
      let person = Person(context: coreDataStack.viewContext)
      person.name = name
      do {
        try coreDataStack.viewContext.save()
        completion()
      } catch {
        print("We were unable to save \(name)")
      }
   }
}
