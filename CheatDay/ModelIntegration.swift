import CoreML

func predictCategory(from goalTitle: String) -> String {
    // Initialize the model
    guard let model = try? CheatDay_Machine_Learning(configuration: .init()) else {
        return "General" // Default category if prediction fails
    }

    do {
        // Make a prediction
        let prediction = try model.prediction(text: goalTitle)
        return prediction.label // Return the predicted category label
    } catch {
        print("Prediction error: \(error.localizedDescription)")
        return "General" // Default category if prediction fails
    }
}
