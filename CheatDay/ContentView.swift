import SwiftUI

struct ContentView: View {
    @State private var goals = [
        Goal(title: "読書", purpose: "リラクゼーション", reward: "もっと読む", encouragement: nil, cycleDays: 7, nextCheatDay: Date()),
        Goal(title: "映画鑑賞", purpose: "エンターテインメント", reward: "別の映画を見る", encouragement: "楽しみ続けてください！", cycleDays: 10, nextCheatDay: Calendar.current.date(byAdding: .day, value: 3, to: Date())!)
    ]
    
    var body: some View {
        MainView(goals: $goals)
            .customFont(size: 20) // Apply the custom font modifier Yomogi-Regular font
            .accentColor(.green) // Set a friendly accent color
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
