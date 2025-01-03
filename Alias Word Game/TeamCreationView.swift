//
//  TeamCreationView.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 12/31/24.
//

import SwiftUI

struct TeamCreationView: View {
    @StateObject var vm = TeamsViewModel()
    
    var body: some View {
        VStack{
            ScrollView{
                if vm.teams.isEmpty{
                    Text("Teams will appear here")
                        .foregroundStyle(.secondary)
                }
                if vm.teams.count == 1{
                    Text("Add at least 2 teams")
                        .foregroundStyle(.secondary)
                }
                ForEach(vm.teams, id: \.self) { team in
                    TeamCell(score: team.score, teamName: team.name, isAccented: false, showingDelete: true, isWon: false)
                        .padding(.horizontal)
                        .environmentObject(vm)
                }
            }
            
            Spacer()
            
            VStack{
                TextField("Enter team name", text: $vm.userInput)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                Button{
                    vm.addTeam(name: vm.userInput)
                } label: {
                    Image(systemName: "plus")
                    Text("Add team")
                }
                .buttonStyle(.borderless)
                .padding()
                .background(Material.thickMaterial)
                .clipShape(.buttonBorder)
                .padding()
            }
            
            
            Button{
                

            } label: {
                NavigationLink(destination: GameSettingsView().environmentObject(vm)){
                    Text("Next")
                }
            }
            .buttonStyle(.borderless)
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(Color.white)
            .clipShape(.buttonBorder)
            .padding()
            .disabled(vm.teams.count < 2)
            
        }
        .environmentObject(vm)
    }
}

#Preview {
    TeamCreationView()
}
