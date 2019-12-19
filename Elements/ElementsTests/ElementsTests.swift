//
//  ElementsTests.swift
//  ElementsTests
//
//  Created by Gregory Keeley on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import Elements
class ElementsTests: XCTestCase {

    func testElementModel() {
       let jsonData = """
             {
                 "name": "Hydrogen",
                 "appearance": "colorless gas",
                 "atomic_mass": 1.008,
                 "boil": 20.271,
                 "category": "diatomic nonmetal",
                 "color": null,
                 "density": 0.08988,
                 "discovered_by": "Henry Cavendish",
                 "melt": 13.99,
                 "molar_heat": 28.836,
                 "named_by": "Antoine Lavoisier",
                 "number": 1,
                 "period": 1,
                 "phase": "Gas",
                 "source": "https://en.wikipedia.org/wiki/Hydrogen",
                 "spectral_img": "https://en.wikipedia.org/wiki/File:Hydrogen_Spectra.jpg",
                 "summary": "Hydrogen is a chemical element with chemical symbol H and atomic number 1. With an atomic weight of 1.00794 u, hydrogen is the lightest element on the periodic table. Its monatomic form (H) is the most abundant chemical substance in the Universe, constituting roughly 75% of all baryonic mass.",
                 "symbol": "H",
                 "xpos": 1,
                 "ypos": 1,
                 "shells": [1]
             }
       """.data(using: .utf8)!
       
       struct Element: Codable {
           let name: String
           let atomicMass: Double
           let boil: Double
           let discoveredBy: String
           let melt: Double
           let number: Int
           let summary: String
           let symbol: String
           
           let category: String
           let period: Double
           let molarHeat: Double
           let phase: String
           let source: String
           let appearance: String
           let density: Double
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
       // Note to self: When originally parsing through two elements, I recieved an error "Garbage at end". Attempting to validate the JSON, it looked
        // like the "}, {" between the two elements was being rejected as invalid JSON? - Verify
       let expectedElementCount = 1
    
       let elements = try! JSONDecoder().decode(Element.self, from: jsonData)
       var elementsArr = [Element]()
        elementsArr.append(elements)
       
       XCTAssertEqual(elementsArr.count, expectedElementCount)
     }

}
