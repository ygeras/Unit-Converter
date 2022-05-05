//
//  ContentView.swift
//  Unit Converter
//
//  Created by Yuri Gerasimchuk on 05.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 0.0
    @State private var inputUnit = "Km"
    @State private var outputUnit = "Km"
    
    @FocusState private var inputIsFocused: Bool
    
    let units = ["Km", "Ft", "Yd", "Ml"]
    
    var result: String {
        let inputToMetersMultiplier: Double
        let metersToOutputMultiplier: Double
        
        switch inputUnit {
        case "Km":
            inputToMetersMultiplier = 1000
        case "Ft":
            inputToMetersMultiplier = 0.3048
        case "Yd":
            inputToMetersMultiplier = 0.9144
        case "Ml":
            inputToMetersMultiplier = 1609.34
        default:
            inputToMetersMultiplier = 1
        }
        
        switch outputUnit {
        case "Km":
            metersToOutputMultiplier = 0.001
        case "Ft":
            metersToOutputMultiplier = 3.28084
        case "Yd":
            metersToOutputMultiplier = 1.09361
        case "Ml":
            metersToOutputMultiplier = 0.000621371
        default:
            metersToOutputMultiplier = 1.0
        }
        
        let inputMeters = input * inputToMetersMultiplier
        let output = inputMeters * metersToOutputMultiplier
        
        let outputString = output.formattedWithSeprator
        return "\(outputString) \(outputUnit.lowercased())"
        
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Enter amount here")
                }
                
                Section {
                    Picker("Unit from", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From unit")
                }
                
                Section {
                    Picker("Unit from", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To unit")
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
                
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Double {
    var formattedWithSeprator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
