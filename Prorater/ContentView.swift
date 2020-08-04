//
//  ContentView.swift
//  Prorater
//
//  Created by Fernando de Orbegoso on 8/4/20.
//  Copyright © 2020 Fernando de Orbegoso. All rights reserved.
//

import SwiftUI

struct ColorManager {
    
    static let ptgreen = Color("ptgreen")
    static let ptyellow = Color("ptyellow")
}

struct ContentView: View {
    
    @State private var rentAmountText = ""
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
        let rentDouble = Double(rentAmountText)!
        let dailyRent = rentDouble / Double(totalDaysInMonth)
        return dailyRent * Double(remainingDaysInMonth)
    }
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient:  Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                Spacer()
                Spacer()
                VStack {
                    Text("Prorater")
                        .font(.title)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack {
                    
                    DatePicker("Select Date", selection: $startDate, displayedComponents: .date)
                    .labelsHidden()
                        .padding(.leading)
                        .colorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                        
                    
                }
                Spacer()
                VStack {
                    TextField("Enter Amount", text : $rentAmountText).padding(.leading) .keyboardType(.decimalPad)
                    Spacer()
                    VStack {
                        if Double(rentAmountText) != nil {
                            Text("Days remaining in month: \(remainingDaysInMonth) days")
                            
                            Text("Prorated amount: \(proratedRent, specifier: "%.2f")")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    VStack {
                        Text("(C) 2020 FdO Enterprises & Holdings LLC") .font(.footnote)
                    }
                }
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

