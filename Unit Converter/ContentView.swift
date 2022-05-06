//
//  ContentView.swift
//  Unit Converter
//
//  Created by Yuri Gerasimchuk on 05.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    
    @FocusState private var inputIsFocused: Bool
    
    let formatter: MeasurementFormatter
    
    let units: [UnitLength] = [.feet, .kilometers, .meters, .miles, .yards]
    
    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        return formatter.string(from: outputMeasurement)
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .medium
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
                            Text(formatter.string(from: $0))
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From unit")
                }
                
                Section {
                    Picker("Unit from", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0))
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
