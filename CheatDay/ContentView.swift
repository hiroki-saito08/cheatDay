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
                .onDelete(perform: deleteCheatDays)
            }
            .navigationTitle("Cheat Days")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: addCheatDay) {
                        Label("Add Cheat Day", systemImage: "plus")
                    }
                }
                #if os(iOS)
                ToolbarItem(placement: .automatic) {
                    EditButton()
                }
                #endif
            }
        }
    }

    private func addCheatDay() {
        let newCheatDay = CheatDay(date: Date(), activities: [])
        cheatDays.append(newCheatDay)
    }

    private func deleteCheatDays(at offsets: IndexSet) {
        cheatDays.remove(atOffsets: offsets)
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
