//
//  UserDefaultsHelper.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 12/30/24.
//
import Foundation

import Foundation

class UserDefaultsHelper {
    private static let teamScoresKey = "teamScoresKey"
    
    static func getTeamScores() -> [String: Int] {
        if let savedData = UserDefaults.standard.dictionary(forKey: teamScoresKey) as? [String: Int] {
            return savedData
        }
        return [:]
    }
    
    static func saveTeamScores(_ scores: [String: Int]) {
        UserDefaults.standard.set(scores, forKey: teamScoresKey)
    }
    
    static func addNewTeam(teamName: String) {
        var teamScores = getTeamScores()
        teamScores[teamName] = 0
        saveTeamScores(teamScores)
    }
    
    static func updateScore(for teamName: String, score: Int) {
        var teamScores = getTeamScores()
        teamScores[teamName] = score
        saveTeamScores(teamScores)
    }
    
    static func clearAllTeams() {
        UserDefaults.standard.removeObject(forKey: teamScoresKey)
    }
}
