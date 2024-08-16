import SwiftUI

struct GoalsView: View {
    @State private var goalName = ""
    @State private var goalPurpose = ""
    @State private var nextCheatDay = Date()
    @State private var cheatDayCycle = ""
    @State private var goals = [Goal]()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("新しい目標")) {
                    TextField("目標名", text: $goalName)
                    TextField("目的", text: $goalPurpose)
                    DatePicker("次のチートデイ", selection: $nextCheatDay, displayedComponents: .date)
                    TextField("周期（日数）", text: $cheatDayCycle)
                    Button("目標を追加") {
                        addGoal()
                    }
                }

                List(goals, id: \.id) { goal in
                    VStack(alignment: .leading) {
                        Text(goal.name).font(.headline)
                        Text("目的: \(goal.purpose)")
                        Text("次のチートデイ: \(goal.nextCheatDay, formatter: itemFormatter)")
                        Text("周期: \(goal.cycle)日")
                    }
                }
            }
            .navigationTitle("目標")
        }
    }

    private func addGoal() {
        let newGoal = Goal(name: goalName, purpose: goalPurpose, nextCheatDay: nextCheatDay, cycle: Int(cheatDayCycle) ?? 0)
        goals.append(newGoal)
        clearInputs()
    }

    private func clearInputs() {
        goalName = ""
        goalPurpose = ""
        cheatDayCycle = ""
        nextCheatDay = Date()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()
