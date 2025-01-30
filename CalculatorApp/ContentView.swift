//
//  ContentView.swift
//  CalculatorApp
//
//  Created by Arpit Jaiswal on 29/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var expArray : [String] = []
    @State private var displayValue: String = "0"
    @State var clearButton : Bool = false

    
    var body: some View {
        VStack {
            VStack {
                Text(displayValue)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Button(action: {
                    print(expArray)
                }, label: {
                    
                })
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomTrailing)

            VStack {
                Grid(horizontalSpacing: 30) {
                    GridRow {
                        ForEach(row1, id: \.self) { item in
                            ButtonIcon(expArray: $expArray,
                                       bgColor: item == "÷" ? .orange : .gray,
                                       opacity: 1,
                                       buttonValue: clearButton ? "C" : item,
                                       displayValue: $displayValue,
                                       clearButton : $clearButton
                            )
                        }
                    }
                    GridRow {
                        ForEach(row2, id: \.self) { item in
                            ButtonIcon(expArray: $expArray,
                                       bgColor: item == "×" ? .orange : .gray.opacity(0.5),
                                       opacity: 1,
                                       buttonValue: item,
                                       displayValue: $displayValue,
                                       clearButton : $clearButton
                            )
                        }
                    }
                    GridRow {
                        ForEach(row3, id: \.self) { item in
                            ButtonIcon(expArray: $expArray,
                                       bgColor: item == "-" ? .orange : .gray.opacity(0.5),
                                       opacity: 1,
                                       buttonValue: item,
                                       displayValue: $displayValue,
                                       clearButton : $clearButton
                            )
                        }
                    }
                    GridRow {
                        ForEach(row4, id: \.self) { item in
                            ButtonIcon(expArray: $expArray,
                                       bgColor: item == "+" ? .orange : .gray.opacity(0.5),
                                       opacity: 1,
                                       buttonValue: item,
                                       displayValue: $displayValue,
                                       clearButton : $clearButton
                            )
                        }
                    }
                }
                Grid(horizontalSpacing: 30) {
                    GridRow {
                        Button(action: { displayValue.append("0") }) {
                            Text("0")
                                .font(.title)
                                .fontWeight(.semibold)
                                .frame(width: 130, alignment: .leading)
                                .padding()
                                .background(Color.gray.opacity(0.5))
                                .foregroundColor(.white)
                                .cornerRadius(100)
                        }
                        ButtonIcon(expArray: $expArray,
                                   bgColor: .gray, opacity: 0.5, buttonValue: ".", displayValue: $displayValue,clearButton : $clearButton)
                        ButtonIcon(expArray: $expArray,
                                   bgColor: .orange, opacity: 1, buttonValue: "=", displayValue: $displayValue,clearButton : $clearButton)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .background(Color.black)
    }}

extension ContentView {
    var row1 : [String] {["AC", "+/-","%", "÷"]}
    var row2 : [String] {["7","8","9","×"]}
    var row3 : [String] { ["4","5","6","-"]}
    var row4 : [String] {["1","2","3","+"]}
    var row5 : [String] {["0",".","="]}
}

#Preview {
    ContentView()
}
