//
//  PeopleTableViewController.swift
//  Cekikapeye
//
//  Created by Ambroise COLLON on 24/05/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

final class PeopleViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var peopleTextView: UITextView!
    @IBOutlet private weak var peopleTextField: UITextField!

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

    private func addPerson() {
        guard let personName = peopleTextField.text,
            var people = peopleTextView.text else {
                return
        }

        people += personName + "\n"
        peopleTextView.text = people
        peopleTextField.text = ""

        // TODO: Save person
    }
}
