import SwiftUI
import CoreML
import GoogleMobileAds // Ensure this import is here for the ads

struct ContentView: View {
    @State private var goals: [Goal] = [] // Initialize with an empty array

    init() {
        // テストデータを削除し、goals は空の状態で初期化
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
