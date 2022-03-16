//
//  ListViewController.swift
//  Cekikapeye
//
//  Created by Ambroise COLLON on 21/05/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    // MARK: - Properties
    private let spendingsRepository = SpendingRepository()
    private let settingsRepository = SettingsRepository()
    private var spendings: [[Spending]] = []

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    // MARK: - View life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spendingsRepository.getSpendings(completion: {[weak self] spendings in
            self?.spendings = spendings
            self?.tableView.reloadData()
        })
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return spendings.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendings[section].count
    }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell", for: indexPath)

            let spending = spendings[indexPath.section][indexPath.row]
        cell.textLabel?.text = spending.content
            cell.detailTextLabel?.text = "\(spending.amount) \(settingsRepository.currency)"

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let person = spendings[section].first?.person else {return nil}

        var totalAmount = 0.0
        for spending in spendings[section]{
            totalAmount += spending.amount
        }
        return "\(person.name ?? " . ") \(totalAmount) \(settingsRepository.currency)"
    }
}
