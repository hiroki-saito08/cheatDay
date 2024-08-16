import SwiftUI

struct GoalsView: View {
    @State private var goals = [Goal]()

    var body: some View {
        NavigationView {
            List {
                ForEach(goals, id: \.id) { goal in
                    VStack(alignment: .leading) {
                        Text(goal.name)
                        Text("目的: \(goal.purpose)")
                        Text("次のチートデイ: \(goal.nextCheatDay, formatter: itemFormatter)")
                        Text("周期: \(goal.cycle)日")
                    }
                }
                .onDelete(perform: deleteGoal)
            }
            .navigationTitle("目標")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("目標を追加") {
                        // Function to add a new goal
                    }
                }
            }
        }
    }

    private func deleteGoal(at offsets: IndexSet) {
        goals.remove(atOffsets: offsets)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()
