//
//  AnswerDashboardView.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 1/1/25.
//

import SwiftUI

struct AnswerDashboardView: View {
    @EnvironmentObject var vm: TeamsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            ScrollView{
                ForEach(Array(vm.words), id: \.key) { word, isCorrect in
                    HStack {
                        Text(word)
                        Spacer()
                        Image(systemName: isCorrect ? "checkmark" : "xmark")
                        HStack{
                            Link(destination: URL(string: "https://www.google.com/search?q=\(word)+definition")!) {
                                Image(systemName: "info.circle")
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            NavigationLink("Next", destination: ScoreDashboardView().environmentObject(vm))
                .onTapGesture {
                    vm.nextViewIsToggled = false
                }
                .buttonStyle(.borderless)
                .padding()
                .background(Color.accentColor)
                .foregroundStyle(Color.white)
                .clipShape(.buttonBorder)
                .padding()
        }
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            NavigationLink(destination: ContentView().navigationBarBackButtonHidden()){
                HStack(spacing: 1){
                    Image(systemName: "xmark")
                    Text("Quit")
                }
            }
        })
        .navigationTitle("Your Answers")
    }
}

#Preview {
    AnswerDashboardView()
}
