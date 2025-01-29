//
//  ContentView.swift
//  CalculatorApp
//
//  Created by Arpit Jaiswal on 29/01/25.
//

import SwiftUI

struct Stack<T> {
    private var elements: [T] = []
    
    mutating func push(_ element : T){
        elements.append(element)
    }
    
    mutating func pop() -> T?{
        elements.popLast()
    }
    
    func top() -> T? {
        return elements.last
    }
    
    var isEmpty : Bool {
        return elements.isEmpty
    }
    
    var count : Int {
        return elements.count
    }
}

func convertToPostfix(infixArray: [String]) -> [String] {
    var result: [String] = []
    var st = Stack<String>()
    
    let precedence: [String: Int] = ["+": 1, "-": 1, "*": 2, "/": 2]
    
    for element in infixArray {
        if let _ = Double(element) {
            result.append(element)
        }
        /*else if element == "(" {
            st.push(element)
        } else if element == ")" {
            while let top = st.top(), top != "(" {
                result.append(st.pop()!)
            }
            st.pop()
        }*/
        else {
            while let top = st.top(),
                  let topPrecedence = precedence[top],
                    let elementPrecedence = precedence[element], topPrecedence >= elementPrecedence {
                result.append(st.pop() ?? "")
            }
            st.push(element)
        }
    }
    while !st.isEmpty {
        result.append(st.pop()!)
    }
    
    return result
}

func evaluatePostfix(postfixArray: [String]) -> Double {
    var stack = Stack<Double>()

    for element in postfixArray {
        if let number = Double(element) {
            stack.push(number)
        } else {
            guard let operand2 = stack.pop(), let operand1 = stack.pop() else {
                return 0.0
            }
            
            switch element {
                case "+": 
                stack.push(operand1 + operand2)
                case "-": 
                stack.push(operand1 - operand2)
                case "*": 
                stack.push(operand1 * operand2)
                case "/":
                    if operand2 == 0 {
                        print("Division by zero is not allowed")
                    }
                stack.push(operand1 / operand2)
                default:
                   print("error")
            }
        }
    }
    
    return stack.pop() ?? 0.0  // Final result
}



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
