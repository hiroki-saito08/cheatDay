import SwiftUI

struct CheatDayView: View {
    var cheatDay: CheatDay

    var body: some View {
        List(cheatDay.activities, id: \.id) { activity in
            VStack(alignment: .leading) {
                Text(activity.name).font(.headline)
                Text(activity.description).font(.subheadline)
            }
        }
        .navigationTitle("Activities on \(cheatDay.date, formatter: itemFormatter)")
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()
