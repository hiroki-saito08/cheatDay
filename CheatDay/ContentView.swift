import SwiftUI

struct ContentView: View {
    @State private var goals = [
        Goal(
            title: "読書の習慣をつける", // 15 characters
            purpose: "毎月2冊読む", // 15 characters
            reward: "新しい本を買う", // 15 characters
            encouragement: "今日は素晴らしい進歩を遂げました！継続は力なり。", // 50 characters
            cycleDays: 7,
            nextCheatDay: Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        ),
        Goal(
            title: "映画鑑賞を楽しむ", // 15 characters
            purpose: "週に1本見る", // 15 characters
            reward: "お気に入りのスナックを食べる", // 15 characters
            encouragement: "映画は心の栄養です。リラックスして楽しんでください。", // 50 characters
            cycleDays: 14,
            nextCheatDay: Calendar.current.date(byAdding: .day, value: 14, to: Date()) ?? Date()
        ),
        Goal(
            title: "運動習慣を身につける", // 15 characters
            purpose: "週3回の運動", // 15 characters
            reward: "好きなデザートを食べる", // 15 characters
            encouragement: "健康は一生の宝。今日も一歩前進しました！", // 50 characters
            cycleDays: 21,
            nextCheatDay: Calendar.current.date(byAdding: .day, value: 21, to: Date()) ?? Date()
        )
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
