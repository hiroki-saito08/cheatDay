import SwiftUI

@main
struct CheatDayApp: App {
    var goalData = GoalData()  // Create an instance of GoalData

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(goalData)  // Provide GoalData to the environment
        }
    }
}
