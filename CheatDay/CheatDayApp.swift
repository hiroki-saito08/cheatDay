import SwiftUI

@main
struct CheatDayApp: App {
    var goalData = GoalData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(goalData)
                .font(.custom("Yomogi-Regular", size: 20)) // Apply globally
        }
    }
}
