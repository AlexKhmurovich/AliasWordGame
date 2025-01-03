//
//  PlayViewModel.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 12/30/24.
//

import Foundation
import SwiftUI

class PlayViewModel: ObservableObject {
    @Published var currentWord: String
    @Published var score: Int
    @Published var winScore: Int
    @Published var timeRemaining: Int
    @Published var currentWordIndex: Int
    @Published var isGameOver: Bool
    @Published var currentTeam: String
    @State private var teamScores: [String: Int] = UserDefaultsHelper.getTeamScores()
    
    
    private let words = ["ornament", "tinsel", "bauble", "wreath", "garland", "mistletoe", "holly", "stocking", "eggnog", "gingerbread"] // Sample list
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(currentTeam: String) {
        self.currentTeam = currentTeam
        self.score = 0
        self.winScore = 25
        self.timeRemaining = 5
        self.currentWordIndex = 0
        self.isGameOver = false
        self.currentWord = words[0]
    }
    
    func startGame() {
        score = 0
        timeRemaining = 60
        winScore = 25
        currentWordIndex = 0
        isGameOver = false
        currentWord = words[currentWordIndex]
    }
    
    func addScore() {
        score += 1
        nextWord()
    }
    
    func subtractScore() {
        score -= 1
        nextWord()
    }
    
    private func nextWord() {
        currentWordIndex += 1
        if currentWordIndex < words.count {
            currentWord = words[currentWordIndex]
        } else {
            isGameOver = true
        }
    }
    
    func handleTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            isGameOver = true
        }
    }
}

