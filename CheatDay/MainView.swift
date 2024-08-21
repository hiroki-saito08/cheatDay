import SwiftUI

struct MainView: View {
    @State private var showCheatDayScreen = false
    @State private var cheatDayGoal: Goal?
    @Binding var goals: [Goal]
    @State private var selectedTab: Int = 0
    @State private var showSettings = false // State to show the settings menu
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    if let goalIndex = goals.firstIndex(where: { $0.id == cheatDayGoal?.id }), showCheatDayScreen {
                        CheatDayScreen(goal: $goals[goalIndex], isPresented: $showCheatDayScreen)
                            .onDisappear {
                                selectedTab = 2 // Assuming the Rewards tab is the third tab
                            }
                    } else {
                        // Content of the selected tab
                        if selectedTab == 0 {
                            GoalsView(goals: $goals)
                        } else if selectedTab == 1 {
                            PlansView(goals: $goals)
                        } else if selectedTab == 2 {
                            RewardsView(goals: $goals)
                        } else if selectedTab == 3 {
                            BattleHistoryView(goals: $goals)
                        }
                    }
                }
                
                // Custom Tab Bar
                CustomTabBarView(
                    selectedTab: $selectedTab,
                    icons: ["notebook", "date", "gift", "curved-arrow"],
                    titles: ["目標", "予定", "褒美", "戦歴"]
                )
            }
            .sheet(isPresented: $showSettings) {
                SettingsView() // Show the settings screen
            }
            .onAppear {
                checkForCheatDay()
            }
        }
    }
    
    func checkForCheatDay() {
        let today = Date()
        let calendar = Calendar.current

        if let lastShownDate = UserDefaults.standard.object(forKey: "LastCheatDayScreenShownDate") as? Date,
           calendar.isDate(lastShownDate, inSameDayAs: today) {
            return
        }
        
        if let goal = goals.first(where: { Calendar.current.isDate($0.nextCheatDay, inSameDayAs: today) }) {
            cheatDayGoal = goal
            showCheatDayScreen = true
            UserDefaults.standard.set(today, forKey: "LastCheatDayScreenShownDate")
        }
    }
}
