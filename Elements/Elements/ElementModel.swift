//
//  ElementModel.swift
//  Elements
//
//  Created by Gregory Keeley on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let atomicMass: Double
    let boil: Double?
    let discoveredBy: String?
    let melt: Double?
    let number: Int
    let summary: String
    let symbol: String
    let category: String
    let period: Double
    let molarHeat: Double?
    let phase: String
    let source: String
    let appearance: String?
    let density: Double?
    let favoritedBy: String?

    enum CodingKeys: String, CodingKey {
        case name
        case atomicMass = "atomic_mass"
        case boil
        case discoveredBy = "discovered_by"
        case melt
        case number
        case summary
        case symbol
        case category
        case period
        case molarHeat = "molar_heat"
        case phase
        case source
        case appearance
        case density
        case favoritedBy
    }
    
}
