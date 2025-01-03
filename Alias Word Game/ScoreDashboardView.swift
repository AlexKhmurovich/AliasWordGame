//
//  ScoreDashboardView.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 12/31/24.
//

import SwiftUI
import ConfettiSwiftUI

struct ScoreDashboardView: View {
    @EnvironmentObject var vm: TeamsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            ScrollView{
                ForEach(vm.teams, id: \.self) { team in
                    TeamCell(score: team.score, teamName: team.name, isAccented: team == vm.teams[vm.currentTeamIndex] && vm.winningTeam == -1, isWon: vm.winningTeam == vm.teams.firstIndex(of: team))
                }
                .padding(.horizontal)
            }
            .onAppear{
                if (vm.currentTeamIndex < vm.teams.count - 1){
                    vm.currentTeamIndex += 1
                } else {
                    vm.currentTeamIndex = 0
                }
                let temp = vm.winningTeam
                if temp != -1 {
                    vm.winningTeam = -1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                        vm.winningTeam = temp
                    }
                }
            }
            
            Spacer()
            
            if (vm.winningTeam == -1){
                NavigationLink(destination: PlayView().environmentObject(vm)){
                    Image(systemName: "play.fill")
                    Text("Next Round")
                }
                .onTapGesture {
                    vm.nextViewIsToggled = false
                }
                .buttonStyle(.borderless)
                .padding()
                .background(Color.accentColor)
                .foregroundStyle(Color.white)
                .clipShape(.buttonBorder)
                .padding()
            } else {
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden()){
                    Image(systemName: "arrow.clockwise")
                    Text("Play Again")
                }
                .buttonStyle(.borderless)
                .padding()
                .background(Color.accentColor)
                .foregroundStyle(Color.white)
                .clipShape(.buttonBorder)
                .padding()
            }
        }
        .confettiCannon(counter: $vm.winningTeam)
        .toolbar(content: {
            if (vm.winningTeam == -1){
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden()){
                    HStack(spacing: 1){
                        Image(systemName: "xmark")
                        Text("Quit")
                    }
                }
            }
        })
        .navigationBarBackButtonHidden()
        .navigationTitle("Scoreboard")
    }
}

#Preview {
    ScoreDashboardView()
}
