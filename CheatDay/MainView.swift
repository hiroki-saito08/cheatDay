import SwiftUI

struct MainView: View {
    @Binding var goals: [Goal]
    @State private var selectedTab: Int = 0
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Main content changes based on selected tab
                if selectedTab == 0 {
                    GoalsView(goals: $goals)
                        .background(Color.green.opacity(0.1).edgesIgnoringSafeArea(.all))
                } else if selectedTab == 1 {
                    PlansView(goals: $goals)
                        .background(Color.green.opacity(0.1).edgesIgnoringSafeArea(.all))
                } else if selectedTab == 2 {
                    RewardsView(goals: $goals)
                        .background(Color.green.opacity(0.1).edgesIgnoringSafeArea(.all))
                } else if selectedTab == 3 {
                    BattleHistoryView(goals: $goals)
                        .background(Color.green.opacity(0.1).edgesIgnoringSafeArea(.all))
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
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
