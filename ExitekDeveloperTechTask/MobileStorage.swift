//
//  MobileStorage.swift
//  ExitekDeveloperTechTask
//
//  Created by Nikita Stambul on 06.09.2022.
//

import Foundation

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}
