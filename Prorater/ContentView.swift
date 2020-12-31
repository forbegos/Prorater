//
//  ContentView.swift
//  Prorater
//
//  Created by Fernando de Orbegoso on 8/4/20.
//  Copyright © 2020 Fernando de Orbegoso. All rights reserved.
//

import SwiftUI
import SwiftUIKit

struct ColorManager {
    
    static let ptgreen = Color("ptgreen")
    static let ptyellow = Color("ptyellow")
}

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
                }
                
                VStack(alignment: .center) {
                    Section {
                        CurrencyTextField(" Enter Amount",  value : self.$rentAmount)
                            .frame(height: 40.0).keyboardType(.decimalPad).background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/) .font(.headline)
                    }
                    VStack {
                      // add button to open calendar here, better UX
                        DatePicker("Select Date", selection: $startDate, displayedComponents: .date)
                            .labelsHidden()
                            .padding(.leading)
                            .colorScheme(.light)
                    }
                            
                    VStack {
                        if rentAmount != nil {
                            Text("Days remaining in month: \(remainingDaysInMonth) days")
                            
                            Text("Prorated amount: $\(proratedRent, specifier: "%.2f")")
                                .fontWeight(.bold)
                        }
                    }
                    Spacer()
                    
                    VStack {
                        Text("(C) 2020 FdO Enterprises & Holdings LLC") .font(.footnote)
                    }
                }
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                
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

