//
//  ContentView.swift
//  CookingCalculator
//
//  Created by Julien Purvis on 12/1/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selected: oven?;
    @State var itemWeight: String = "";
    @State var desiredTemp: String = "";
    @State private var ovens: [oven] = [setOvens(name: "Traditional Oven", pc: 3000, mult: 1), setOvens(name: "Convection Oven", pc: 2500, mult: 2), setOvens(name: "MicroWave Oven", pc: 800, mult: 10)]
    
    var body: some View {
        HStack{
        NavigationView{
            List(ovens, selection: $selected){ oven in
                Text(oven.name)
                    .tag(oven)
                
            }
            
        }
        .frame(width: 150)
            VStack {

            if let selected = selected,
               let indexOfSelected = ovens.firstIndex(of: selected){
                OvenView(oven: ovens[indexOfSelected])
                    .padding(.vertical)
            } else {
                TextField("Object Weight", text: $itemWeight)
                        .padding(.horizontal)
                TextField("Desired Temp", text: $itemWeight)
                            .padding(.horizontal)
            }
        }
    }
    }
}

func setOvens(name: String, pc: Int, mult: Double)->oven{
    let oven1: oven = oven(name: name, powerConsumption: pc, cookMult: mult)
    return(oven1);
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
