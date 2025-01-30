//MARK: Implementation of stack

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

//MARK: converting an given expression to postfix evaluation

func convertToPostfix(infixArray: [String]) -> [String] {
    var result: [String] = []
    var st = Stack<String>()
    
    let precedence: [String: Int] = ["+": 1, "-": 1, "*": 2, "/": 2]
    
    for element in infixArray {
        if let _ = Double(element) {
            result.append(element)
        }
        else if element == "(" {
            st.push(element)
        } else if element == ")" {
            while let top = st.top(), top != "(" {
                result.append(st.pop()!)
            }
            _ = st.pop()
        }
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


//MARK: Evaluation of postfix expression to generate result 
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
