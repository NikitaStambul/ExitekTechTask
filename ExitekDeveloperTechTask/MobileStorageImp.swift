//
//  MobileStorageImp.swift
//  ExitekDeveloperTechTask
//
//  Created by Nikita Stambul on 06.09.2022.
//

import Foundation

class MobileStorageImp: MobileStorage {

    var storage: Set<Mobile> {
        didSet {
            let encoder = JSONEncoder()
            guard let data = try? encoder.encode(storage) else { return }
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: storageKey)
        }
    }

    let storageKey = "MobileStorageImpKey"

    enum StorageErrors: Error {
        case elementDoesNotExist
        case elementAlreadyExist
    }

    func getAll() -> Set<Mobile> {
        return storage
    }

    func findByImei(_ imei: String) -> Mobile? {
        for mobile in storage {
            if imei == mobile.imei {
                return mobile
            }
        }
        return nil
    }

    func save(_ mobile: Mobile) throws -> Mobile {
        let (inserted, element) = storage.insert(mobile)
        if inserted == false {
            throw StorageErrors.elementAlreadyExist
        } else {
            return element
        }

        // depending on desired behavior (replace old with new value or not) we could use .update instead
        // guard let result = storage.update(with: mobile) else { throw StorageErrors.elementDoesNotExist }
        // return result
    }

    func delete(_ product: Mobile) throws {
        guard let _ = storage.remove(product) else { throw StorageErrors.elementDoesNotExist }
    }

    func exists(_ product: Mobile) -> Bool {
        return storage.contains(product)
    }

    init() {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: storageKey) else {
            self.storage = []
            return
        }
        let decoder = JSONDecoder()
        guard let storage = try? decoder.decode(Set<Mobile>.self, from: data) else {
            self.storage = []
            return
        }
        self.storage = storage
    }


}
