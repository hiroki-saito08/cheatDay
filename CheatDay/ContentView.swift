import SwiftUI
import CoreML
import GoogleMobileAds // Ensure this import is here for the ads

struct ContentView: View {
    @State private var goals: [Goal] = [] // Initialize with an empty array

    init() {
        // Initialize with the existing goals, ensuring the category is set correctly
        let initialGoals = [
            ("読書の習慣をつける", "毎月2冊読む", "新しい本を買う", "今日は素晴らしい進歩を遂げました！継続は力なり。", 0),
            ("映画鑑賞を楽しむ", "週に1本見る", "お気に入りのスナックを食べる", "映画は心の栄養です。リラックスして楽しんでください。", 14),
            ("運動習慣を身につける", "週3回の運動", "好きなデザートを食べる", "健康は一生の宝。今日も一歩前進しました！", 21)
        ]

        self._goals = State(initialValue: initialGoals.map { title, purpose, reward, encouragement, cycleDays in
            Goal(
                title: title,
                purpose: purpose,
                reward: reward,
                encouragement: encouragement,
                cycleDays: cycleDays,
                nextCheatDay: Calendar.current.date(byAdding: .day, value: cycleDays, to: Date()) ?? Date(),
                category: predictCategory(from: title) // Predict category for each goal
            )
        })
    }

    var body: some View {
        MainView(goals: $goals)
            .customFont(size: 20) // Apply the custom font modifier Yomogi-Regular font
            .accentColor(.green) // Set a friendly accent color
    }

    // Move the prediction function inside the ContentView to avoid redeclaration
    private func predictCategory(from goalTitle: String) -> String {
        guard let model = try? CheatDay_Machine_Learning(configuration: .init()) else {
            return "General" // Default category if prediction fails
        }

        do {
            let prediction = try model.prediction(text: goalTitle)
            return prediction.label // Return the predicted category label
        } catch {
            print("Prediction error: \(error.localizedDescription)")
            return "General" // Default category if prediction fails
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
