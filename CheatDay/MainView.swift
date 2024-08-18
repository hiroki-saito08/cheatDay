import SwiftUI

struct MainView: View {
    @State private var showCheatDayScreen = false
    @State private var cheatDayGoal: Goal?
    @Binding var goals: [Goal]
    @State private var selectedTab: Int = 0
    
    var body: some View {
        Group {
            if let goalIndex = goals.firstIndex(where: { $0.id == cheatDayGoal?.id }), showCheatDayScreen {
                CheatDayScreen(goal: $goals[goalIndex], isPresented: $showCheatDayScreen)
                    .onDisappear {
                        // Redirect to the Rewards page after closing CheatDayScreen
                        selectedTab = 2 // Assuming the Rewards tab is the third tab
                    }
            } else {
                // Regular content with TabView
                TabView(selection: $selectedTab) {
                    GoalsView(goals: $goals)
                        .tabItem {
                            Label("目標", systemImage: "target")
                        }
                        .tag(0)
                    
                    PlansView(goals: $goals)
                        .tabItem {
                            Label("予定", systemImage: "calendar")
                        }
                        .tag(1)
                    
                    RewardsView(goals: $goals)
                        .tabItem {
                            Label("褒美", systemImage: "gift")
                        }
                        .tag(2)
                    
                    BattleHistoryView(goals: $goals)
                        .tabItem {
                            Label("戦歴", systemImage: "chart.line.uptrend.xyaxis")
                        }
                        .tag(3)
                }
            }
        }
        .onAppear {
            checkForCheatDay()
        }
    }
    
    func checkForCheatDay() {
        let today = Date()
        let calendar = Calendar.current

        // Re-enable the check to see if the CheatDayScreen was already shown today
        if let lastShownDate = UserDefaults.standard.object(forKey: "LastCheatDayScreenShownDate") as? Date,
           calendar.isDate(lastShownDate, inSameDayAs: today) {
            print("CheatDayScreen was already shown today.")
            return
        }
        
        // Check if today is a cheat day for any goal
        if let goal = goals.first(where: { Calendar.current.isDate($0.nextCheatDay, inSameDayAs: today) }) {
            print("Today is a cheat day for goal: \(goal.title)")
            cheatDayGoal = goal
            showCheatDayScreen = true
            // Set the current date in UserDefaults to prevent showing it again today
            UserDefaults.standard.set(today, forKey: "LastCheatDayScreenShownDate")
        }
    }


}
