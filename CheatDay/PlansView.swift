import SwiftUI

struct PlansView: View {
    @State private var selectedDate = Date()

    // Example static data
    let goals = [
        Goal(name: "読書", purpose: "Relaxation", nextCheatDay: Date(), cycle: 7),
        Goal(name: "映画鑑賞", purpose: "Entertainment", nextCheatDay: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, cycle: 10)
    ]

    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "日付を選択",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

                List {
                    ForEach(goals.filter { Calendar.current.isDate($0.nextCheatDay, inSameDayAs: selectedDate) }) { goal in
                        Text("チートデイ: \(goal.name)")
                    }
                }
            }
            .navigationTitle("予定")
        }
    }
}

// Assuming Goal is defined as before
