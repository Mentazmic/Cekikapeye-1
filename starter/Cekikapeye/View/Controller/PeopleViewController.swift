//
//  PeopleTableViewController.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 03/11/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import UIKit
import CoreData

final class PeopleViewController: UIViewController {
    // MARK: - Properties

    private let repository = PeopleRepository()

    // MARK: - Outlets

    @IBOutlet private weak var peopleTextView: UITextView!
    @IBOutlet private weak var peopleTextField: UITextField!

    // MARK: - View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getPeople()
    }

    // MARK: - Actions

    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension PeopleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addPerson()
        return true
    }
    private func getPeople() {
      repository.getPersons(completion: { [weak self] persons in
        var peopleText = ""
        for person in persons {
          if let name = person.name {
             peopleText += name + "\n"
          }
        }
        self?.peopleTextView.text = peopleText
      })
    }

    private func addPerson() {
        guard
            let personName = peopleTextField.text,
            var people = peopleTextView.text
        else { return }

        repository.savePerson(named: personName, completion: { [weak self] in
            people += personName + "\n"
            self?.peopleTextView.text = people
            self?.peopleTextField.text = ""
        })
    }

    private func savePerson(name: String) {
        let person = Person(context: CoreDataStack.sharedInstance.viewContext)
        person.name = name
        do {
            try CoreDataStack.sharedInstance.viewContext.save()
        } catch {
            print("We were unable to save \(String(describing: person.name))")
        }
    }
}
