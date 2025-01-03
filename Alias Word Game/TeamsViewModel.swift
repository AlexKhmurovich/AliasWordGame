//
//  TeamsViewModel.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 12/31/24.
//

import Foundation
import Combine

class TeamsViewModel: ObservableObject {
    @Published var teams:[Team] = []
    @Published var words: [(key: String, value: Bool)] = []
    @Published var currentTeamIndex = 0
    
    @Published var initialTimeRemaining = 60
    @Published var timeRemaining = 60
    @Published var timerIsRunning = false
    private var timer: AnyCancellable?
    
    @Published var isFirstRound = false
    
    @Published var penalizeWrong = true
    
    @Published var isLastWord = false
    @Published var nextViewIsToggled = false
    @Published var scoreToWin = 50
    
    @Published var winningTeam = -1
    
    @Published var currentWord = "Dog"
    @Published var userInput = ""
    var wordsList = Words().normalWords
    var currentWordIndex = 0
    
    func changeScore(correct: Bool) {
        if correct{
            words.append((key: self.currentWord, value: true))
            teams[currentTeamIndex].score += 1
        } else {
            words.append((key: self.currentWord, value: false))
            if penalizeWrong {
                teams[currentTeamIndex].score -= 1
            }
        }
        if teams[currentTeamIndex].score >= scoreToWin{
            winningTeam = currentTeamIndex
        }
        if isLastWord {
            print("Last word reached. Setting nextViewIsToggled = true")
            nextViewIsToggled = true
        } else{
            currentWordIndex += 1
            currentWord = wordsList[currentWordIndex]
        }
    }
    
    func randomWord(){
        currentWord = wordsList[currentWordIndex]
    }
    
    func startRound(){
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
        words = []
        wordsList.shuffle()
        timeRemaining = initialTimeRemaining
        timerIsRunning = true
        isLastWord = false
        userInput = ""
        currentWordIndex = 0
        currentWord = wordsList[currentWordIndex]
    }
    
    func addTeam(name: String) {
        if !teams.contains(where: { $0.name == name }) && name != ""{
            teams.append(Team(name: name, score: 0))
        }
        userInput = ""
    }
    
    func deleteTeam(name: String){
        teams.removeAll(where: { $0.name == name })
    }
    
    func updateTimer() {
        if timerIsRunning && timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timerIsRunning = false
            stopTimer()
            isLastWord = true
        }
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    func saveSettings() {
        let defaults = UserDefaults.standard
        
        defaults.set(initialTimeRemaining, forKey: "initialTimeRemaining")
        defaults.set(scoreToWin, forKey: "scoreToWin")
        defaults.set(penalizeWrong, forKey: "penalizeWrong")
    }
    
    func loadSettings() {
        let defaults = UserDefaults.standard
        
        if let savedTimeRemaining = defaults.value(forKey: "initialTimeRemaining") as? Int {
            initialTimeRemaining = savedTimeRemaining
        }
        
        if let savedScoreToWin = defaults.value(forKey: "scoreToWin") as? Int {
            scoreToWin = savedScoreToWin
        }
        
        if let savedPenalizeWrong = defaults.value(forKey: "penalizeWrong") as? Bool {
            penalizeWrong = savedPenalizeWrong
        }
    }
}
