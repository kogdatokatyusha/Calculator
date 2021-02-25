//
//  ContentView.swift
//  Calculator
//
//  Created by user on 16/12/2020.
//

import SwiftUI

enum CalculatorButton: String {
    case zero, one, two, three, four, five,
         six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case decimal
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        case .decimal: return "."
        case .plusMinus: return "+/-"
        case .percent: return "%"
        default:
            return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalDisplayEnv
    
    let buttons: [String: [CalculatorButton]] = [
        "1" : [.ac, .plusMinus, .percent, .divide],
        "2" : [.seven, .eight, .nine, .multiply],
        "3" : [.four, .five, .six, .minus],
        "4" : [.one, .two, .three, .plus],
        "5" : [.zero, .decimal, .equals]
        ]
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
            
            VStack(spacing: 12) {
                HStack{
                    Spacer()
                    Text(env.result)
                        .font(.system(size: 64))
                        .foregroundColor(.white)
                }.padding()
                ForEach(buttons.keys.sorted(by: <),
                        id: \.self) {
                    key in
                    
                    HStack(spacing: 12) {
                        ForEach(buttons[key]!, id: \.self) {
                            button in
                            
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }
          
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalDisplayEnv())
    }
}

struct CalculatorButtonView: View {
    
    var button : CalculatorButton
    
    @EnvironmentObject var env: GlobalDisplayEnv
    
    var body: some View {
        Button(action: {
           self.env.inputAction(calculatorButton: self.button)
        }, label: {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(40)
        })
        }
        private func buttonWidth(button: CalculatorButton) -> CGFloat {
            if button == .zero {
                return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
                
            }
            return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}
