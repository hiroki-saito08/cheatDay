import SwiftUI
import CoreML
import GoogleMobileAds

struct ContentView: View {
    @State private var goals: [Goal] = [] // Initialize with an empty array

    var body: some View {
        MainView(goals: $goals)
            .customFont(size: 20) // Apply the custom font modifier Yomogi-Regular font
            .accentColor(.green) // Set a friendly accent color
            .onAppear {
                // アプリ起動時にデータを UserDefaults から読み込む
                if let savedGoals = loadGoals() {
                    goals = savedGoals
                }
            }
            .onDisappear {
                // アプリ終了時にデータを保存
                saveGoals()
            }
    }

    // データを UserDefaults に保存
    func saveGoals() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(goals) {
            UserDefaults.standard.set(encoded, forKey: "savedGoals")
        }
    }

    // データを UserDefaults から読み込む
    func loadGoals() -> [Goal]? {
        if let savedGoals = UserDefaults.standard.data(forKey: "savedGoals") {
            let decoder = JSONDecoder()
            return try? decoder.decode([Goal].self, from: savedGoals)
        }
        return nil
    }

    // Prediction function for goal category
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
