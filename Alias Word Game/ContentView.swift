//
//  ContentView.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 12/28/24.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    @State var isSheetPresented = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    Spacer()
                    
                    Text("Alias")
                        .font(.largeTitle)
                        .bold()
                    Text("The Word Game")
                        .font(.title)
                        
                    Spacer()
                    
                    
                    HStack {
                        Button{
                            isSheetPresented.toggle()
                        } label: {
                            Image(systemName: "book")
                            Text("Rules")
                        }
                        .buttonStyle(.borderless)
                        .padding()
                        .background(Material.thickMaterial)
                        .clipShape(.buttonBorder)
                        .sheet(isPresented: $isSheetPresented) {
                            AliasGameRulesView()
                        }
                        
                        NavigationLink {
                            TeamCreationView()
                        } label: {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                        .buttonStyle(.borderless)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(.buttonBorder)
                    }
                    
                }
            }

        }
    }
}

struct AliasGameRulesView: View {
    var body: some View {
        TabView {
            StepView(stepTitle: "Step 1: Click 'Play'", description: "Press the 'Play' button to begin the game. Once the game starts, you’ll move on to adding teams and adjusting settings.")
                .tabItem {
                    Label("Step 1", systemImage: "play.fill")
                }
            
            StepView(stepTitle: "Step 2: Add Teams", description: "Create teams to play. You can add multiple teams (usually 2 or more). Each team should have a name and an initial score of 0.")
                .tabItem {
                    Label("Step 2", systemImage: "person.3.fill")
                }
            
            StepView(stepTitle: "Step 3: Adjust Settings", description: "Before starting, you can adjust the following settings:\n- Time: Set the time for each round (e.g., 15, 30, 45, or 60 seconds).\n- Score to Win: Set the target score (e.g., 50 points).\n- Penalty for Wrong Answers: Decide if there should be a penalty for incorrect answers (e.g., -1 point).\n- Set: Choose a word set to play with. (e.g., Winter Holidays)")
                .tabItem {
                    Label("Step 3", systemImage: "slider.horizontal.3")
                }
            
            StepView(stepTitle: "Step 4: Start the Game", description: "After setting up the teams and adjusting the settings, click 'Start' to begin the game. The first round and first team will start.")
                .tabItem {
                    Label("Step 4", systemImage: "play.circle.fill")
                }
            
            StepView(stepTitle: "Step 5: Game Rules", description: "In each round, one player describes a word or phrase to their teammates without using the word itself, while the teammates try to guess it.\n- No gestures, sounds, or rhyming allowed.\n- Points are awarded for correct guesses, and penalties for wrong answers (if enabled). The last word can be guessed for an infinite amount of time")
                .tabItem {
                    Label("Step 5", systemImage: "gamecontroller.fill")
                }
            
            StepView(stepTitle: "Step 6: Winning the Game", description: "Once a team reaches the target score, they win the game! Celebrate with confetti and cheers, then choose to play again or end the game.")
                .tabItem {
                    Label("Step 6", systemImage: "trophy.fill")
                }
            
            StepView(stepTitle: "Step 7: Enjoy", description: "Have fun! The goal is to guess words quickly while time is running out. The first team to reach the target score wins! \n\nConfetti Credits: Copyright (c) 2020 Simon Bachmann\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the 'Software'), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\naUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE."
)
                .tabItem {
                    Label("Step 7", systemImage: "star.fill")
                }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct StepView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var stepTitle: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(stepTitle)
                .font(.title)
                .bold()
                .foregroundColor(.blue)
            
            ScrollView{
                Text(description)
                    .font(.body)
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            if stepTitle != "Step 7: Enjoy" {
                HStack{
                    Spacer()
                    Image(systemName: "chevron.right")
                    Text("Swipe to see more steps")
                    Spacer()
                }
            } else {
                HStack {
                    Spacer()
                    Button("Got It!"){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                
            }
        }
        .padding(.vertical)
        .cornerRadius(10)
        .padding()
    }
}


#Preview {
    ContentView()
}
