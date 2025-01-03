//
//  GameSettingsView.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 1/2/25.
//

import SwiftUI

struct GameSettingsView: View {
    @EnvironmentObject var vm: TeamsViewModel
    
    var body: some View {
        VStack{
            Spacer()
            
            HStack {
                VStack{
                    Label("Time", systemImage: "clock")
                    Picker(selection: $vm.initialTimeRemaining, label: Text("Time")) {
                        Text("15").tag(15)
                        Text("30").tag(30)
                        Text("45").tag(45)
                        Text("60").tag(60)
                    }
                    .pickerStyle(.wheel)
                    .onChange(of: vm.initialTimeRemaining) { _ in
                        vm.saveSettings()
                    }
                }
                
                VStack{
                    Label("Score to win", systemImage: "flag.checkered")
                    Picker(selection: $vm.scoreToWin, label: Text("Time")) {
                        ForEach(15..<51) { num in
                            Text("\(num)").tag(num)
                        }
                    }
                    .pickerStyle(.wheel)
                    .onChange(of: vm.scoreToWin) { _ in
                        vm.saveSettings()
                    }
                }
            }
            
            Toggle("-1 for wrong answers", isOn: $vm.penalizeWrong)
                .padding(.horizontal)
                .onChange(of: vm.penalizeWrong) { _ in
                    vm.saveSettings()
                }
            
            Spacer()
            
            NavigationLink(destination: PlayView().environmentObject(vm)){
                Image(systemName: "play.fill")
                Text("Start Game")
            }
            .buttonStyle(.borderless)
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(Color.white)
            .clipShape(.buttonBorder)
            .padding()
        }
        .navigationTitle("Settings")
        .onAppear {
            vm.loadSettings()
        }
    }
}


#Preview {
    GameSettingsView()
}
