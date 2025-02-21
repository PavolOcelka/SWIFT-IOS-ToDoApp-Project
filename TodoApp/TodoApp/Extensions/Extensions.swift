//
//  Extensions.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 06/02/2025.
//

import Foundation
import SwiftUI

extension LinearGradient {
    public static var elementGradient: LinearGradient {
        return LinearGradient(colors: [Color(.sRGB, red: 195/255, green: 55/255, blue: 100/255), Color(.sRGB, red: 29/255, green: 38/255, blue: 113/255)], startPoint: .leading, endPoint: .trailing)
    }
    
    public static var elementGradient2: LinearGradient {
        return LinearGradient(colors: [Color(.sRGB, red: 15/255, green: 12/255, blue: 41/255), Color(.sRGB, red: 48/255, green: 43/255, blue: 99/255)], startPoint: .leading, endPoint: .trailing)
    }
    
    public static var elementGradient3: LinearGradient {
        return LinearGradient(colors: [Color(.sRGB, red: 9/255, green: 48/255, blue: 40/255), Color(.sRGB, red: 35/255, green: 122/255, blue: 87/255)], startPoint: .leading, endPoint: .trailing)
    }
    
    public static var elementGradientWhite: LinearGradient {
        return LinearGradient(colors: [Color(.sRGB, red: 255/255, green: 255/255, blue: 255/255)], startPoint: .leading, endPoint: .trailing)
    }
    
    public static var elementGradientGreen: LinearGradient {
        return LinearGradient(colors: [Color(.sRGB, red: 0/255, green: 128/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing)
    }
}
