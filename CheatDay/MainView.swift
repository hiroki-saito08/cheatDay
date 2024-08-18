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
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: today)
        
        if let lastShownDate = UserDefaults.standard.object(forKey: "LastCheatDayScreenShownDate") as? Date,
           calendar.isDate(lastShownDate, inSameDayAs: today) {
            // CheatDayScreen was already shown today, so do nothing
            return
        }
        
        if let goal = goals.first(where: { Calendar.current.isDate($0.nextCheatDay, inSameDayAs: today) }) {
            cheatDayGoal = goal
            showCheatDayScreen = true
            // Mark that the screen has been shown today
            UserDefaults.standard.set(today, forKey: "LastCheatDayScreenShownDate")
        }
    }
}
