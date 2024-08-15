import SwiftUI

struct CheatDayView: View {
    @State var cheatDay: CheatDay

    var body: some View {
        List {
            ForEach($cheatDay.activities) { $activity in
                HStack {
                    TextField("Activity Name", text: $activity.name)
                    TextField("Description", text: $activity.description)
                    Spacer()
                    #if os(macOS)
                    Button(action: {
                        if let index = cheatDay.activities.firstIndex(where: { $0.id == activity.id }) {
                            cheatDay.activities.remove(at: index)
                        }
                    }) {
                        Image(systemName: "trash")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    #endif
                }
            }
            Button("Add Activity") {
                addActivity()
            }
        }
        .navigationTitle("Activities on \(cheatDay.date, formatter: itemFormatter)")
    }

    private func addActivity() {
        cheatDay.activities.append(Activity(name: "New Activity", description: "Description here"))
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()
