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
    
    @Published var wordListFromEnum = WordListType.normal
    var wordsList: [String] = []
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
            if currentWordIndex < wordsList.count - 1{
                currentWordIndex += 1
            } else {
                currentWordIndex = 0
                wordsList.shuffle()
            }
            currentWord = wordsList[currentWordIndex]
        }
    }
    
    func randomWord(){
        currentWord = wordsList[currentWordIndex]
    }
    
    func startRound(){
        wordsList = setWordsList()
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
    
    func setWordsList() -> [String]{
        switch wordListFromEnum {
        case .normal:
            return Words().normalWords
        case .belarusian:
            return Words().belarusianWords
        case .emojis:
            return Words().emojiWords
        case .genZ:
            return Words().genZWords
        case .landmarks:
            return Words().landmarksWords
        case .winterHolidays:
            return Words().winterHolidaysWords
        }
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
