//
//  ContentView.swift
//  Unit Converter
//
//  Created by Yuri Gerasimchuk on 05.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var selectedUnits = 0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    
    @FocusState private var inputIsFocused: Bool
    
    let formatter: MeasurementFormatter
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    
    let unitTypes = [
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    
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
                    Picker("Conversion", selection: $selectedUnits) {
                        ForEach(0..<conversions.count, id: \.self) {
                            Text(conversions[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Conversions")
                }
                
                Section {
                    Picker("Unit from", selection: $inputUnit) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0))
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From unit")
                }
                
                Section {
                    Picker("Unit from", selection: $outputUnit) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
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
            .onChange(of: selectedUnits) { newValue in
                let units = unitTypes[newValue]
                inputUnit = units[0]
                outputUnit = units[1]
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
