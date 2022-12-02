//
//  Oven.swift
//  CookingCalculator
//
//  Created by Julien Purvis on 12/1/22.
//

import Foundation

let waterPower: Double = 4200.00


class oven: Identifiable, Hashable, ObservableObject{
    static func == (lhs: oven, rhs: oven) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID;
    var name: String
    var powerConsumption: Int
    var cookMult: Double
    
    
    init(name: String, powerConsumption: Int, cookMult: Double) {
        self.id = UUID()
        self.name = name;
        self.powerConsumption = powerConsumption;
        self.cookMult = cookMult;
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    static func basic() -> oven {
        return oven(name: "Electric Oven", powerConsumption: 4200, cookMult: 1)
    }
    
    public func avgPowerCost() -> Double {
        return 0.22
    }
    
}
