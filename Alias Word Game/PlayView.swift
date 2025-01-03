//
//  PlayView.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 12/29/24.
//
import SwiftUI

struct PlayView: View {
    @EnvironmentObject var vm: TeamsViewModel
    @State private var shouldNavigate = false
    
    var body: some View {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Team: \(vm.teams[vm.currentTeamIndex].name)")
                Text("Score: \(vm.teams[vm.currentTeamIndex].score) / \(vm.scoreToWin)")
                Text("Time: \(vm.timeRemaining)")
                
                Text(vm.currentWord)
                    .font(.largeTitle)
                
                Spacer()
                
                
                HStack {
                    Button {
                        vm.changeScore(correct: false)
                    } label: {
                        if (vm.timeRemaining > 0){
                           Image(systemName: "x.circle.fill")
                       } else {
                           NavigationLink(destination: AnswerDashboardView().environmentObject(vm).onAppear(perform: {
                               vm.changeScore(correct: false)
                      })){
                               Image(systemName: "x.circle.fill")
                           }
                       }
                    }
                    .font(.system(size: 50))
                    .foregroundStyle(.red)
                    
                    Button {
                        vm.changeScore(correct: true)
                    } label: {
                        if (vm.timeRemaining > 0){
                           Image(systemName: "checkmark.circle.fill")
                       } else {
                           NavigationLink(destination: AnswerDashboardView().environmentObject(vm).onAppear(perform: {
                                    vm.changeScore(correct: true)
                           })){
                               Image(systemName: "checkmark.circle.fill")
                           }
                       }
                    }
                    .font(.system(size: 50))
                    .foregroundStyle(.green)
                }
            }
            .toolbar(content: {
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden()){
                    HStack(spacing: 1){
                        Image(systemName: "xmark")
                        Text("Quit")
                    }
                }
            })
            .navigationBarBackButtonHidden()
            .onAppear{
                shouldNavigate = true
                vm.nextViewIsToggled = false
                vm.startRound()
            }

    }
}


#Preview {
    PlayView()
}
