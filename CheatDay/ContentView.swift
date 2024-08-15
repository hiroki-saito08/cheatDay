import SwiftUI

struct ContentView: View {
    @State private var cheatDays: [CheatDay] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(cheatDays, id: \.id) { cheatDay in
                    NavigationLink(destination: CheatDayView(cheatDay: cheatDay)) {
                        Text("Cheat Day on \(cheatDay.date, formatter: itemFormatter)")
                    }
                }
            }
            .navigationTitle("Cheat Days")
            .toolbar {
                ToolbarItem(placement: .automatic) { // For macOS, use .automatic or specific placement like .primaryAction
                    Button(action: addCheatDay) {
                        Label("Add Cheat Day", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addCheatDay() {
        let newCheatDay = CheatDay(date: Date(), activities: [])
        cheatDays.append(newCheatDay)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
