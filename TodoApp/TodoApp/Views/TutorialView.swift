//
//  TutorialView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 25/02/2025.
//

import SwiftUI

struct TutorialView: View {
    
    @Binding var wasShown: Bool
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Welcome")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundStyle(.white)
                Spacer()
            }
            VStack {
                TabView {
                    Tab {
                        VStack {
                            Text("Goals")
                                .foregroundStyle(.white)
                                .font(.largeTitle.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.horizontal, .top])
                            Text("Add goals, track your progress, and stay motivated. \nCreating main goal will help you to organize tasks and track your progress.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            Text("Main Goal")
                                .foregroundStyle(.white)
                                .frame(width: 200, height: 50)
                                .background(LinearGradient.elementGradient3)
                                .clipShape(Capsule())
                            Text("Weekly Goal")
                                .foregroundStyle(.white)
                                .frame(width: 200, height: 50)
                                .background(LinearGradient.elementGradient)
                                .clipShape(Capsule())
                            Text("Monthly Goal")
                                .foregroundStyle(.white)
                                .frame(width: 200, height: 50)
                                .background(LinearGradient.elementGradient2)
                                .clipShape(Capsule())
                            Spacer()
                        }
                        .frame(width: 300, height: 400)
                        .background(.white.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    Tab {
                        VStack {
                            Text("Tasks")
                                .foregroundStyle(.white)
                                .font(.largeTitle.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.horizontal, .top])
                            Text("Add tasks, mark them as complete, and organize your day. \nFind the plus (+) button to add a new task.")
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding()
                            Spacer()
                        }
                        .frame(width: 300, height: 400)
                        .background(.white.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    
                }
                .tabViewStyle(.page)
                
                Button(action: {withAnimation{wasShown.toggle()}}) {
                    Text("Let's start")
                        .font(.title2.bold())
                        .foregroundStyle(.black)
                }
                .frame(width: 300, height: 50)
                .background(.white)
                .clipShape(Capsule())

            }
            .padding()
        }
    }
}

#Preview {
    TutorialView(wasShown: .constant(false))
}
