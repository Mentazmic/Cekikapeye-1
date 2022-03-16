//
//  SettingsRepository.swift
//  Cekikapeye
//
//  Created by Maxime Landu-Wa on 15/03/2022.
//  Copyright © 2022 OpenClassrooms. All rights reserved.
//

import Foundation

final class SettingsRepository {
    //MARK: - Private
    private enum Keys {
        static let currency = "currency"
    }

    //MARK: - Public

    var currency: String{
        get{
            return UserDefaults.standard.string(forKey: Keys.currency) ?? "€"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currency)
        }
    }
}
