//
//  TeamCell.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 12/30/24.
//

import SwiftUI

struct TeamCell: View {
    var score: Int
    var teamName: String
    var isAccented: Bool
    var showingDelete: Bool = false
    var isWon: Bool
    
    @EnvironmentObject var vm: TeamsViewModel
    
    var body: some View {
        HStack {
            if isWon {
                Image(systemName: "trophy")
            }
            
            Text(teamName)
                .bold()
            
            Spacer()
            
            if !showingDelete{
                Text("\(score)")
            }
            
            
            if showingDelete{
                Button(action: {
                    vm.deleteTeam(name: teamName)
                }) {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.secondary)
                        .padding(10)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .background(isAccented && !isWon ? Color.green.gradient : (isWon ? Color.orange.gradient : Color.gray.gradient))
        .clipShape(.buttonBorder)
    }
}


#Preview {
    TeamCell(score: 50, teamName: "Fat Santas", isAccented: true, showingDelete: true, isWon: false)
}
