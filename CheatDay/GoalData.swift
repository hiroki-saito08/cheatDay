import Foundation

class GoalData: ObservableObject {
    @Published var goals: [Goal]

    init(goals: [Goal] = []) {
        self.goals = goals
    }
}
