import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GoalsView()
                .tabItem {
                    Label("目標", systemImage: "target")
                }

            PlansView()
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
