//
//  OvenView.swift
//  CookingCalculator
//
//  Created by Julien Purvis on 12/1/22.
//

import SwiftUI
import Foundation

struct OvenView: View {
    
    @ObservedObject var oven: oven
    @State var timeRemaining:Int = 0
    @State var onTime: Bool = false;
    @State var itemWeight: Double = 0;
    @State var desiredTemp: Double = 0;
    @State var roomTemp: Double = 0;
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Text("Cook Time \(timeRemaining) S")
                .font( .largeTitle)
                       .onReceive(timer) { _ in
                           if timeRemaining > 0 && onTime {
                               timeRemaining -= 1
                           }
                       }
            Button(action: {
                onTime = !onTime
            }, label: {
                if(onTime){
                    Text("Pause")
                } else {
                    Text("Start")
                }
            })
            .frame(maxWidth: 150)
            
            HStack{
                VStack(alignment: .leading){
                Text("Oven Power: \(oven.powerConsumption)W")
                    Text("Total Power: \(Int(itemWeight * 5040 * (desiredTemp - roomTemp) * (20.00 / oven.cookMult)))W")
                }.padding(.horizontal)
                VStack(alignment: .leading){
                    Text("Avg Cost per Kw/h: $\(oven.avgPowerCost())")
                    let dM = Double(oven.powerConsumption) / 1000
                    Text("Total Cost: $\((Double(timeRemaining) / 60 / 60) * oven.avgPowerCost() * dM)")
                }
            }

            HStack{
                VStack{
                    HStack{
                Text("Item Weight Kg:")
                TextField("Item Weight", value: $itemWeight, format: .number)
                            .padding(.horizontal)
                    }
                    HStack{
                Text("Desired Temp C:")
                TextField("Item Weight", value: $desiredTemp, format: .number)
                            .padding(.horizontal)
                    }
                    HStack{
                Text("Room Temp C:")
                TextField("Item Weight", value: $roomTemp, format: .number)
                            .padding(.horizontal)
                    }
                }
                Button (action: {
                    let dM = (Double(oven.powerConsumption) * 0.05) * Double(oven.cookMult)
                    timeRemaining = Int(((itemWeight * 5040 * (desiredTemp - roomTemp)) / (dM)))
                }, label: {
                    Text("Calculate")
                        .padding()
                })
            }
        }
    }
}
struct OvenViewContainer: View {
    @State var ov = oven.basic()
    var body: some View {
        OvenView(oven: ov)
    }
}



struct OvenView_Previews: PreviewProvider {
    static var previews: some View {
        OvenViewContainer()
    }
}
