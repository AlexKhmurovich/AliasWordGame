import Foundation


class TeamScoresViewModel: ObservableObject {
    @Published var teamScores: [Team] = []

    private let adjectives = [
        "Brave", "Bold", "Mighty", "Swift", "Clever", "Fierce", "Wise", "Noble", "Glorious", "Majestic"
    ]

    private let nouns = [
        "Lions", "Wolves", "Titans", "Dragons", "Eagles", "Bears", "Sharks", "Falcons", "Panthers", "Knights"
    ]

    func addNewTeam(teamName: String) {
        guard !teamScores.contains(where: { $0.name == teamName }) else { return }
        teamScores.append(Team(name: teamName, score: 0))
        saveToUserDefaults()
    }

    func generateUniqueTeamName() -> String? {
        let availableNames = adjectives.flatMap { adj in
            nouns.map { noun in "\(adj) \(noun)" }
        }
        let existingNames = Set(teamScores.map { $0.name })
        let unusedNames = availableNames.filter { !existingNames.contains($0) }

        return unusedNames.randomElement()
    }

    func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "teamScores"),
           let decoded = try? JSONDecoder().decode([Team].self, from: data) {
            teamScores = decoded
        }
    }

    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(teamScores) {
            UserDefaults.standard.set(encoded, forKey: "teamScores")
        }
    }

    init() {
        loadFromUserDefaults()
    }
}
