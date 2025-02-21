//
//  BrainDumpTab.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 17/02/2025.
//

import SwiftUI

struct BrainDumpTab: View {
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Text("Brain Dump Entry")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                Text("content")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 220)
            .padding()
        }
    }
}

#Preview {
    BrainDumpTab()
}
