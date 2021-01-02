//
//  ContentView.swift
//  Prorater
//
//  Created by Fernando de Orbegoso on 8/4/20.
//  Copyright © 2020 Fernando de Orbegoso. All rights reserved.
//  v1.6 

import SwiftUI
import SwiftUIKit

struct ContentView: View {
    
    @State private var rentAmount: Double? = 0.0
    @State private var startDate = Date()
    
    var totalDaysInMonth : Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: startDate)
        return range!.count
    }
    
    var remainingDaysInMonth : Int {
        let calendar = Calendar.current
        let selectedDate = calendar.component(.day, from: startDate)
        let remainingDays = (totalDaysInMonth - Int(selectedDate)) + 1
        return remainingDays
        
    }
    
    var proratedRent : Double {
        let rentDouble = rentAmount!
        let dailyRent = rentDouble / Double(totalDaysInMonth)
        return dailyRent * Double(remainingDaysInMonth)
    }
    
    var dailyRent : Double {
        let rentDouble = rentAmount!
        let rate = rentDouble / Double(totalDaysInMonth)
        return rate
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient:  Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                VStack {
                    Text("Prorater")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 15.0)
                    Text("v1.6")
                    .foregroundColor(.white)
                }
                
                VStack(alignment: .center) {
                    
                    Section {
                        CurrencyTextField(" Enter Amount",  value : self.$rentAmount)
                            .frame(height: 40.0).keyboardType(.decimalPad).background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/) .font(.headline)
                    }
                    
                    if rentAmount != nil {
                        Text("Days remaining in month: \(remainingDaysInMonth) days")
                        
                        Text("Prorated amount: $\(proratedRent, specifier: "%.2f")")
                            .fontWeight(.bold)
                        Text("Daliy rate: $\(dailyRent, specifier: "%.2f")")
                            .fontWeight(.bold)
                    }
                    
                    VStack {
                        DatePicker("Select Date", selection: $startDate, displayedComponents: .date)
                            .labelsHidden()
                            .padding(.leading)
                            .colorScheme(.light)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .previewLayout(.device)
                .previewDevice("iPhone 12 Pro Max")
        }
    }
}


