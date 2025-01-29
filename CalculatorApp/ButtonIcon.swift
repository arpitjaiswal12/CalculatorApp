//
//  ButtonIcon.swift
//  CalculatorApp
//
//  Created by Arpit Jaiswal on 29/01/25.
//

import SwiftUI


struct ButtonIcon: View {
    @Binding var expArray : [String]
    var bgColor : Color = .blue
    var opacity : Double = 1
    @State var buttonValue : String = ""
    var buttonWidth : CGFloat = 65
    var buttonHeight : CGFloat = 65
    @Binding var displayValue: String
    @State var str1 : Int = 0
    @State var str2 : Int = 0
    @Binding var clearButton : Bool 
    
    
    var body: some View {
        VStack {
            Button(action: {
                print(buttonValue)
                if buttonValue.count > 0 {
                    clearButton = true
                }
                if let _ = Int(buttonValue){
                    displayValue.append(buttonValue)
//                    displayValue = "0"
                    print(displayValue)
                } else {
                    switch buttonValue {
                    case "+":
                        expArray.append(displayValue)
                        expArray.append("+") 
                        displayValue = "0"
                    case ".":
                        displayValue.append(".")
                    case "-":
                        expArray.append(displayValue)
                        expArray.append("-")
                        displayValue = "0"
                    case "×":
                        expArray.append(displayValue)
                        expArray.append("*")
                        displayValue = "0"
                    case "÷":
                        expArray.append(displayValue)
                        expArray.append("/")
                        displayValue = "0"
                    case "=":
                        expArray.append(displayValue)
                        expArray = convertToPostfix(infixArray: expArray)
                        print(evaluatePostfix(postfixArray: expArray))
                        displayValue =  String(evaluatePostfix(postfixArray: expArray))
//                        displayValue = "0"
                    case "AC":
                        expArray = []
                        displayValue = "0"
                        clearButton = false
                        
                    default:
                        print("error")
                    }
                }
                print(expArray)

            }, label: {
                Text("\(buttonValue == "AC" && clearButton ? "C" : buttonValue)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(bgColor)
                            .frame(width: buttonWidth, height: buttonHeight)
                            .opacity(opacity)
                    )
                    .frame(width: buttonWidth, height: buttonHeight)
                    
            })
            
            
        }
    }
}

#Preview {
    ButtonIcon(expArray: .constant([""]), displayValue: .constant(""),clearButton: .constant(true))
}
