import SwiftUI

struct ContentView: View {
    @EnvironmentObject var goalData: GoalData  // Ensures it’s expected to find GoalData
    @State private var goals = [
        Goal(title: "読書", purpose: "リラクゼーション", reward: "もっと読む", encouragement: nil, cycleDays: 7, nextCheatDay: Date()),
        Goal(title: "映画鑑賞", purpose: "エンターテインメント", reward: "別の映画を見る", encouragement: "楽しみ続けてください！", cycleDays: 10, nextCheatDay: Calendar.current.date(byAdding: .day, value: 3, to: Date())!)
    ]

    var body: some View {
        TabView {
            GoalsView(goals: $goals)
                .tabItem {
                    Label("目標", systemImage: "target")
                }
            
            PlansView(goals: $goals)
                .tabItem {
                    Label("予定", systemImage: "calendar")
                }

            RewardsView()
                .tabItem {
                    Label("褒美", systemImage: "gift")
                }

            CoursesView()
                .tabItem {
                    Label("戦歴", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
